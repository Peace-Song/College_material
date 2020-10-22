%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%define api.push-pull both
%define parse.error verbose
%union {int integer;}
%token <integer> X
%code {
#include <stdio.h> /* printf. */

#if defined __GNUC__ && (7 == __GNUC__ || 9 == __GNUC__)
# pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
#endif

  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
}
%%
exp:
  X { printf ("x\n"); }
;

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
  static int const input[] = {X, 0};
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  ;

  return res;
}
