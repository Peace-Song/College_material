%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%define parse.assert
%glr-parser
%destructor { parent_rhs_before_value = 0; } parent_rhs_before

%{
# include <stdlib.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
  static int parent_rhs_before_value = 0;
# define USE(val)
%}

%%

start:
  alt1 %dprec 1
  | alt2 %dprec 2
  ;

/* This stack must be merged into the other stacks *last* (added at the
   beginning of the semantic options list) so that yyparse will choose to clean
   it up rather than the tree for which some semantic actions have been
   performed.  Thus, if yyreportAmbiguity longjmp's to yyparse, the values from
   those other trees are not cleaned up.  */
alt1: ;

alt2:
  parent_rhs_before ambiguity {
    USE ($1);
    parent_rhs_before_value = 0;
  }
  ;

parent_rhs_before:
  {
    USE ($$);
    parent_rhs_before_value = 1;
  }
  ;

ambiguity: ambiguity1 | ambiguity2 ;
ambiguity1: ;
ambiguity2: ;

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
  int exit_status = yyparse () != 1;
  if (parent_rhs_before_value)
    {
      fprintf (stderr, "'parent_rhs_before' destructor not called.\n");
      exit_status = 1;
    }
  return exit_status;
}
