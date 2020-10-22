%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%define parse.error verbose
%debug
%code {
#include <stdio.h>

static void yyerror (const char *msg);
static int yylex (void);
}
%union {
  int ival;
}
%type <ival> exp
%%
exp:     <ival>{ $$ = 0; }
     '1' <ival>{ $$ = 1; }
     '2' <ival>{ $$ = 2; }
     '3' <ival>{ $$ = 3; }
     '4' <ival>{ $$ = 4; }
     '5' <ival>{ $$ = 5; }
     '6' <ival>{ $$ = 6; }
     '7' <ival>{ $$ = 7; }
     '8' <ival>{ $$ = 8; }
     '9' <ival>{ $$ = 9; }  <ival>{ $$ = 10; }  <ival>{ $$ = 11; }
  {
    $$ = $1 + $3 + $5 + $7 + $9 + $11 + $13 + $15 + $17 + $19 + $20 + $21;
    printf ("%d\n", $$);
  }
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
  static char const input[] = "123456789";
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
