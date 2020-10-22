%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%{
# include <stdlib.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
  static int destructors = 0;
# define USE(val)
%}

%define parse.assert
%glr-parser
%union { int dummy; }
%type <int> 'a'
%destructor { destructors += 1; } 'a'

%%

start:
    'a' %dprec 2 { USE ($1); destructors += 1; YYACCEPT; }
  | 'a' %dprec 1 { USE ($1); destructors += 1; YYACCEPT; }
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

int
main (void)
{
  int exit_status = yyparse ();
  if (destructors != 1)
    {
      fprintf (stderr, "Destructor calls: %d\n", destructors);
      return 1;
    }
  return exit_status;
}
