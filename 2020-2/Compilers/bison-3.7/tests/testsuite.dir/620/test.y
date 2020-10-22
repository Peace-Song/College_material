%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%code requires {
#include <memory> // unique_ptr
}
%code {

  static yy::parser::symbol_type yylex ();
}
%skeleton "lalr1.cc"
%define api.token.constructor
%define api.value.type variant
%define api.value.automove
%token ONE TWO EOI 0
%type <std::unique_ptr<int>> ONE TWO one two one.opt two.opt
%%
exp: one.opt two.opt { std::cout << *$1 << ", " << *$2 << '\n'; }
one.opt: one | %empty {}
two.opt: two | %empty {}
one: ONE
two: TWO
%%
/* A C++ error reporting function.  */
void
yy::parser::error (const std::string& m)
{
  std::cerr << m << '\n';
}
#include <assert.h>
static
yy::parser::symbol_type yylex ()
{
  static char const input[] = "12";
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
   if (res == '1')
    return yy::parser::make_ONE (std::make_unique<int> (10));
  else if (res == '2')
    return yy::parser::make_TWO (std::make_unique<int> (20));
  else
    return yy::parser::make_EOI ();
;
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
