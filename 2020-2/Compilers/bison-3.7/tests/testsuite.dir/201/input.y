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
#include <string.h>
#include <assert.h>





/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
/* The current argument. */
static const char *input;

static int
yylex (void)
{
  static size_t toknum;
  assert (toknum <= strlen (input));
  return input[toknum++];
}

%}

%define parse.error verbose

%nonassoc '<' '>'

%%
expr: expr '<' expr
    | expr '>' expr
    | '0'
    ;
%%
int
main (int argc, const char *argv[])
{
  input = argc <= 1 ? "" : argv[1];
  return yyparse ();
}
