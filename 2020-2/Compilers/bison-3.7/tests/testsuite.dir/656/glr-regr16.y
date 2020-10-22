%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%define parse.assert
%glr-parser
%destructor { lookahead_value = 0; } 'b'

%{
# include <stdlib.h>
# include <assert.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
  static int lookahead_value = 0;
# define USE(val)
%}

%%

start: alt1 'a' | alt2 'a' ;
alt1: ;
alt2: ;

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
  static char const input[] = "ab";
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  if (res == 'b')
    lookahead_value = 1;

  return res;
}

int
main (void)
{
  int exit_status = yyparse () != 1;
  if (lookahead_value)
    {
      fprintf (stderr, "Lookahead destructor not called.\n");
      exit_status = 1;
    }
  return exit_status;
}
