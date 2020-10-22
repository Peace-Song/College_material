%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%define api.prefix {x1_}

%define parse.error verbose
%union
{
  int integer;
}
%{
#include <stdio.h> /* printf. */

  #include <stdio.h>

static void x1_error (const char *msg);
  static int x1_lex (void);
%}
%%
exp:
  'x' '1' { printf ("x1\n"); }
| 'x' '2' { printf ("x2\n"); }
| 'x' '3' { printf ("x3\n"); }
| 'x' '4' { printf ("x4\n"); }
| 'x' '5' { printf ("x5\n"); }
| 'x' '6' { printf ("x6\n"); }
| 'x' '7' { printf ("x7\n"); }
| 'x' '8' { printf ("x8\n"); }
| 'x' '9' { printf ("x9\n"); }
;

%%




/* A C error reporting function.  */
static
void x1_error (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
#include <assert.h>
static
int x1_lex (void)
{
  static char const input[] = "x1";
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  ;

  return res;
}
