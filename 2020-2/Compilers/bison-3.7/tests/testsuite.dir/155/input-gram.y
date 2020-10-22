%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%skeleton "yacc.c"
%{
  #include <stdio.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  int yylex (void);
%}

%define parse.error verbose
%token 'a'

%%

start: ;

%%





/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
int
yylex (void)
{
  return 'a';
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
