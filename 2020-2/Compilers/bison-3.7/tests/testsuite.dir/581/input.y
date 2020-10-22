%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%code {
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
  #define YYSTACK_USE_ALLOCA 1
}

%define parse.error verbose

%%

start: check syntax_error syntax_error ;

check:
{
  if (128 < sizeof yymsgbuf)
    {
      fprintf (stderr,
               "The initial size of yymsgbuf in yyparse has increased\n"
               "since this test group was last updated.  As a result,\n"
               "this test group may no longer manage to induce a\n"
               "reallocation of the syntax error message buffer.\n"
               "This test group must be adjusted to produce a longer\n"
               "error message.\n");
      YYABORT;
    }
}
;

// Induce a syntax error message whose total length is more than
// sizeof yymsgbuf in yyparse.  Each token here is 64 bytes.
syntax_error:
  "123456789112345678921234567893123456789412345678951234567896123A"
| "123456789112345678921234567893123456789412345678951234567896123B"
| error 'a' 'b' 'c'
;

%%





/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
  /* Induce two syntax error messages (which requires full error
     recovery by shifting 3 tokens) in order to detect any loss of the
     reallocated buffer.  */
#include <assert.h>
static
int yylex (void)
{
  static char const input[] = "abc";
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  ;

  return res;
}
#include <stdlib.h> /* getenv. */
#include <string.h> /* strcmp. */
int
main (int argc, char const* argv[])
{
  (void) argc;
  (void) argv;
  return yyparse ();
}
