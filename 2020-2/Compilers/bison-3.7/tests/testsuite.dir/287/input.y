%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%locations

%name-prefix "my_"
%{
#include <stdio.h>
#include <stdlib.h>





/* A C error reporting function.  */
static
void my_error (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
#include <assert.h>
static
int my_lex (void)
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
%}
%%
exp: %empty;
