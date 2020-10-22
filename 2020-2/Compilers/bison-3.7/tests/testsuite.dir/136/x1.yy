%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%skeleton "lalr1.cc"
%define api.namespace {x1}
%defines
         %locations
         %define api.location.file "include/ast/loc.hh"

%code {

  static int yylex (x1::parser::semantic_type *lvalp, x1::parser::location_type *llocp);
}
%%
exp: '0';
%%
/* A C++ error reporting function.  */
void
x1::parser::error (const location_type& l, const std::string& m)
{
  std::cerr << l << ": " << m << '\n';
}
#include <assert.h>
static
int yylex (x1::parser::semantic_type *lvalp, x1::parser::location_type *llocp)
{
  static char const input[] = "0";
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
