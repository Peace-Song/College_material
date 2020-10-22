%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%{
# include <stdlib.h>
# include <stdio.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
  #define GARBAGE_SIZE 50
  static char garbage[GARBAGE_SIZE];
%}

%define parse.assert
%glr-parser
%union { char *ptr; }
%type <ptr> start

%%

start:
    %dprec 2 { $$ = garbage; YYACCEPT; }
  | %dprec 1 { $$ = garbage; YYACCEPT; }
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

int
main (void)
{
  int i;
  for (i = 0; i < GARBAGE_SIZE; i+=1)
    garbage[i] = 108;
  return yyparse ();
}
