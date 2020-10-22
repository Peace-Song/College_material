%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

/* Regression Test: Improper state compression */
/* Reported by Scott McPeak */

%{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define YYSTYPE int
static YYSTYPE exprMerge (YYSTYPE x0, YYSTYPE x1);
#include <stdio.h>

static void yyerror (const char *msg);
static int yylex (void);
%}


%define parse.assert
%glr-parser

/* -------- productions ------ */
%%

StartSymbol: E  { $$=0; }                   %merge <exprMerge>
           ;

E: E 'P' E { $$=1; printf("E -> E 'P' E\n"); }  %merge <exprMerge>
 | 'B'     { $$=2; printf("E -> 'B'\n"); }      %merge <exprMerge>
 ;



/* ---------- C code ----------- */
%%

static YYSTYPE exprMerge (YYSTYPE x0, YYSTYPE x1)
{
  (void) x0;
  (void) x1;
  printf ("<OR>\n");
  return 0;
}

const char *input = YY_NULLPTR;

int
main (int argc, const char* argv[])
{
  assert (argc == 2); (void) argc;
  input = argv[1];
  return yyparse ();
}





/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}

int
yylex (void)
{
  return *input++;
}
