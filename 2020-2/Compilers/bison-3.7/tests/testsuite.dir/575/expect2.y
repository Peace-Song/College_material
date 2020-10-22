%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%{
static int yylex (int *);
#include <cstdlib>
%}
%skeleton "lalr1.cc"
%define parse.error verbose
%token A 1000
%token B

%%
program: %empty
 | program e ';'
 | program error ';';

e: e '+' t | t;
t: A | B;

%%
/* A C++ error reporting function.  */
void
yy::parser::error (const std::string& m)
{
  std::cerr << m << '\n';
}
int
yyparse ()
{
  yy::parser parser;
  return parser.parse ();
}


#include <assert.h>
static int
yylex (int *lval)
{
  static int const tokens[] =
    {
      1000, '+', '+', -1
    };
  static size_t toknum;
  *lval = 0; /* Pacify GCC.  */
  assert (toknum < sizeof tokens / sizeof *tokens);
  return tokens[toknum++];
}
#include <cstdlib> // getenv.
#include <cstring> // strcmp.
int
main (int argc, char const* argv[])
{
  yy::parser p;
  (void) argc;
  (void) argv;
  return p.parse ();
}
