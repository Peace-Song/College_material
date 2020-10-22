%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%locations
%debug
%skeleton "glr.cc"


%code
{
#include <stdio.h> /* putchar. */

static int yylex (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp);
}
%%
exp: %empty;
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
  static char const input[] = "";
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

int
main (void)
{
  yy::parser::location_type loc;
loc.initialize();
#define TEST(L1, C1, L2, C2)          \
  loc.begin.line = L1;           \
  loc.begin.column = C1;         \
  loc.end.line = L2;            \
  loc.end.column = C2;          \
  std::cout << loc;\
  putchar ('\n');

  TEST(1, 1, 1, 1);
  TEST(2, 1, 2, 10);
  TEST(3, 1, 4, 1);
  TEST(5, 1, 6, 10);

  TEST(7, 2, 0, 2);
  TEST(8, 0, 8, 0);
  return 0;
}
