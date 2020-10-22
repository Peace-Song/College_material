%code {#include <assert.h>}
%code {#define A B}
%code {#define B C}
%code {#define C D}
%code {#define D 42}
%code {
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
}
%%
start: %empty;
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
int main (void)
{
  assert (A == 42);
  return 0;
}
