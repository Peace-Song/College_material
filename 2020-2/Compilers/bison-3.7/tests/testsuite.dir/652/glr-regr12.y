%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%define parse.assert
%glr-parser
%union { int dummy; }
%token PARENT_RHS_AFTER
%type <dummy> parent_rhs_before merged PARENT_RHS_AFTER
%destructor { parent_rhs_before_value = 0; } parent_rhs_before
%destructor { merged_value = 0; } merged
%destructor { parent_rhs_after_value = 0; } PARENT_RHS_AFTER

%{
# include <stdlib.h>
# include <assert.h>
  static int merge (YYSTYPE, YYSTYPE);
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
  static int parent_rhs_before_value = 0;
  static int merged_value = 0;
  static int parent_rhs_after_value = 0;
# define USE(val)
%}

%%

start:
  alt1 %dprec 1
  | alt2 %dprec 2
  ;

alt1:
  PARENT_RHS_AFTER {
    USE ($1);
    parent_rhs_after_value = 0;
  }
  ;

alt2:
  parent_rhs_before merged PARENT_RHS_AFTER {
    USE (($1, $2, $3));
    parent_rhs_before_value = 0;
    merged_value = 0;
    parent_rhs_after_value = 0;
  }
  ;

parent_rhs_before:
  {
    USE ($$);
    parent_rhs_before_value = 1;
  }
  ;

merged:
  %merge<merge> {
    USE ($$);
    merged_value = 1;
  }
  | cut %merge<merge> {
    USE ($$);
    merged_value = 1;
  }
  ;

cut: { YYACCEPT; } ;

%%

static int
merge (YYSTYPE s1, YYSTYPE s2)
{
  /* Not invoked. */
  return s1.dummy + s2.dummy;
}





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
  static int const input[] = { PARENT_RHS_AFTER, 0 };
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  if (res == PARENT_RHS_AFTER)
    parent_rhs_after_value = 1;;

  return res;
}

int
main (void)
{
  int exit_status = yyparse ();
  if (parent_rhs_before_value)
    {
      fprintf (stderr, "'parent_rhs_before' destructor not called.\n");
      exit_status = 1;
    }
  if (merged_value)
    {
      fprintf (stderr, "'merged' destructor not called.\n");
      exit_status = 1;
    }
  if (parent_rhs_after_value)
    {
      fprintf (stderr, "'PARENT_RHS_AFTER' destructor not called.\n");
      exit_status = 1;
    }
  return exit_status;
}
