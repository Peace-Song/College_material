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
# define USE(Var)
}

%union
{
  int val;
};

%type <val> a_1 a_2 a_5
            sum_of_the_five_previous_values

%%
exp: a_1 a_2 { $<val>$ = 3; } { $<val>$ = $<val>3 + 1; } a_5
     sum_of_the_five_previous_values
    {
       USE (($1, $2, $<foo>3, $<foo>4, $5));
       printf ("%d\n", $6);
    }
;
a_1: { $$ = 1; };
a_2: { $$ = 2; };
a_5: { $$ = 5; };

sum_of_the_five_previous_values:
    {
       $$ = $<val>0 + $<val>-1 + $<val>-2 + $<val>-3 + $<val>-4;
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
#include <stdlib.h> /* getenv. */
#include <string.h> /* strcmp. */
int
main (int argc, char const* argv[])
{
  (void) argc;
  (void) argv;
  return yyparse ();
}
