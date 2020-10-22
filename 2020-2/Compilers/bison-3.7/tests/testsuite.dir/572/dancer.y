%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%code provides
{

  static int yylex (yy::parser::semantic_type *lvalp);
}
%skeleton "lalr1.cc"
%token ARROW INVALID NUMBER STRING DATA
%verbose
%define parse.error verbose
/* Grammar follows */
%%
line: header body
   ;

header: '<' from ARROW to '>' type ':'
   | '<' ARROW to '>' type ':'
   | ARROW to type ':'
   | type ':'
   | '<' '>'
   ;

from: DATA
   | STRING
   | INVALID
   ;

to: DATA
   | STRING
   | INVALID
   ;

type: DATA
   | STRING
   | INVALID
   ;

body: %empty
   | body member
   ;

member: STRING
   | DATA
   | '+' NUMBER
   | '-' NUMBER
   | NUMBER
   | INVALID
   ;
%%
/* A C++ error reporting function.  */
void
yy::parser::error (const std::string& m)
{
  std::cerr << m << '\n';
}
#include <assert.h>
static
int yylex (yy::parser::semantic_type *lvalp)
{
  static char const input[] = ":";
  static int toknum = 0;
  int res;
  (void) lvalp;
  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  ;

  return res;
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
