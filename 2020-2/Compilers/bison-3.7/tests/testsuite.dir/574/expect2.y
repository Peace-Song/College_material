%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%{
static int yylex (void);

#include <stdio.h>

static void yyerror (const char *msg);
%}
%glr-parser
%define parse.error verbose
%token A 1000
%token B

%%
program: %empty
 | program e ';'
 | program error ';';

e: e '+' t | t;
t: A | B;

%%




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}


#include <assert.h>
static int
yylex (void)
{
  static int const tokens[] =
    {
      1000, '+', '+', -1
    };
  static size_t toknum;

  assert (toknum < sizeof tokens / sizeof *tokens);
  return tokens[toknum++];
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
