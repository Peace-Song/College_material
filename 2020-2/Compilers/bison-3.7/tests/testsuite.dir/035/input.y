%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%token WITH-DASH
%token WITHOUT_DASH "WITHOUT-DASH"
%token WITH.PERIOD
%token WITHOUT_PERIOD "WITHOUT.PERIOD"
%code {
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
}
%%
start: with-dash without_dash with.period without_period;
with-dash: WITH-DASH;
without_dash: "WITHOUT-DASH";
with.period: WITH.PERIOD;
without_period: "WITHOUT.PERIOD";
%%




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
#include <assert.h>
static
int yylex (void)
{
  static char const input[] = "";
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  ;

  return res;
}
