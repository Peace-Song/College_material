%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%code provides
{
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
}

%token ARROW INVALID NUMBER STRING DATA
%verbose
%define parse.error verbose
/* Grammar follows */
%%
line: header body
   ;

header: '<' from ARROW to '>' type ':'
   | '<' ARROW to '>' type ':'
   | ARROW to type ':'
   | type ':'
   | '<' '>'
   ;

from: DATA
   | STRING
   | INVALID
   ;

to: DATA
   | STRING
   | INVALID
   ;

type: DATA
   | STRING
   | INVALID
   ;

body: %empty
   | body member
   ;

member: STRING
   | DATA
   | '+' NUMBER
   | '-' NUMBER
   | NUMBER
   | INVALID
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
  static char const input[] = ":";
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
