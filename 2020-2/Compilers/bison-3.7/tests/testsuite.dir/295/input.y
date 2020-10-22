%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%language "c++"
%define parse.error verbose
%union {int integer;}
%token <integer> X
%code {
#include <stdio.h> /* printf. */


  static int yylex (yy::parser::semantic_type *lvalp);
}
%%
exp:
  X { printf ("x\n"); }
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
  static int const input[] = {yy::parser::token::X, 0};
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
