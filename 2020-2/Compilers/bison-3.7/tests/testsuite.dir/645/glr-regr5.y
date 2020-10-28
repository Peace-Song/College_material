%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
  enum { MAGIC_VALUE = -1057808125 }; /* originally chosen at random */
%}

%define parse.assert
%glr-parser
%union { int value; }
%type <value> start

%destructor {
  if ($$ != MAGIC_VALUE)
    {
      fprintf (stderr, "Bad destructor call.\n");
      exit (EXIT_FAILURE);
    }
} start

%%

start:
   'a' { $$ = MAGIC_VALUE; }
   | 'a' { $$ = MAGIC_VALUE; }
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
  static char const input[] = "a";
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