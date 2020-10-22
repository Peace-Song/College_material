%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%locations %language "c++" %glr-parser
%define parse.error verbose
%union {int integer;}
%token <integer> X
%code {
#include <stdio.h> /* printf. */


  static int yylex (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp);
}
%%
exp:
  X { printf ("x\n"); }
;

%%
/* A C++ error reporting function.  */
void
yy::parser::error (const location_type& l, const std::string& m)
{
  std::cerr << l << ": " << m << '\n';
}
#include <assert.h>
static
int yylex (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp)
{
  static int const input[] = {yy::parser::token::X, 0};
  static int toknum = 0;
  int res;
  (void) lvalp;(void) llocp;
  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  ;

  (*llocp).begin.line = (*llocp).end.line = 1;
  (*llocp).begin.column = (*llocp).end.column = toknum;
  return res;
}
