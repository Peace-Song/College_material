%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

/* Regression Test: Improper merging of GLR delayed action sets.  */
/* Reported by M. Rosien */

%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <assert.h>

static int MergeRule (int x0, int x1);
#include <stdio.h>

static void yyerror (const char *msg);
static int yylex (void);

#define RULE(x) (1 << (x))

%}

%define parse.assert
%glr-parser

%token BAD_CHAR
%token P1 P2 T1 T2 T3 T4 O1 O2

%%

S : P1 T4 O2 NT6 P2  { printf ("Result: %x\n", $4); }
;

NT1 : P1 T1 O1 T2 P2 { $$ = RULE(2); }  %merge<MergeRule>
;

NT2 : NT1             { $$ = RULE(3); } %merge<MergeRule>
    | P1 NT1 O1 T3 P2 { $$ = RULE(4); } %merge<MergeRule>
;

NT3 : T3              { $$ = RULE(5); } %merge<MergeRule>
    | P1 NT1 O1 T3 P2 { $$ = RULE(6); } %merge<MergeRule>
;

NT4 : NT3              { $$ = RULE(7); } %merge<MergeRule>
    | NT2              { $$ = RULE(8); } %merge<MergeRule>
    | P1 NT2 O1 NT3 P2 { $$ = RULE(9); } %merge<MergeRule>
;

NT5 : NT4              { $$ = RULE(10); } %merge<MergeRule>
;

NT6 : P1 NT1 O1 T3 P2  { $$ = RULE(11) | $2; } %merge<MergeRule>
    | NT5              { $$ = RULE(12) | $1; } %merge<MergeRule>
;

%%

static int
MergeRule (int x0, int x1)
{
  return x0 | x1;
}




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}

FILE *input = YY_NULLPTR;

int P[] = { P1, P2 };
int O[] = { O1, O2 };
int T[] = { T1, T2, T3, T4 };

int yylex (void)
{
  char inp[3];
  assert (!feof (stdin));
  if (fscanf (input, "%2s", inp) == EOF)
    return 0;
  switch (inp[0])
    {
    case 'p': return P[inp[1] - '1'];
    case 't': return T[inp[1] - '1'];
    case 'o': return O[inp[1] - '1'];
    }
  return BAD_CHAR;
}

int
main (int argc, char* argv[])
{
  int res;
  input = stdin;
  if (argc == 2 && !(input = fopen (argv[1], "r")))
    return 3;
  res = yyparse ();
  if (argc == 2 && fclose (input))
    return 4;
  return res;
}
