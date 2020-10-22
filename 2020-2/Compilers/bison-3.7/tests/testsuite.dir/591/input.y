%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%{
  #include <assert.h>
  #include <stdio.h>
#include <stdio.h>

static void yyerror (const char *msg);
static int yylex (void);
%}

%define api.push-pull both

%%

start: ;

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

int
main (void)
{
  int i;
  for (i = 0; i < 2; ++i)
    {
      yypstate *ps = yypstate_new ();
      assert (ps);
      assert (yypstate_new () == YY_NULLPTR);
      assert (yyparse () == 2);
      yychar = 0;
      assert (yypush_parse (ps) == 0);
      assert (yypstate_new () == YY_NULLPTR);
      assert (yyparse () == 2);
      yypstate_delete (ps);
    }

  return 0;
}
