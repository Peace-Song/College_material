%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%define parse.error verbose
%skeleton "yacc.c"
%%
%nonassoc 'a';

start: 'a' consistent-error-on-a-a 'a';

consistent-error-on-a-a:
    'a' default-reduction
  | 'a' default-reduction 'a'
  ;

default-reduction: %empty;

%code {
  #include <stdio.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
};
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
  static char const input[] = "aa";
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
