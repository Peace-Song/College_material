%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%code {
  #include <stdio.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
}
%token A B C
%token D
%right E F G
%right H I
%right J
%left  K
%left  L M N
%nonassoc O P Q
%precedence R S T U
%precedence V W
%%
exp: A
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
int main (void)
{
  assert (A < B);
  assert (B < C);
  assert (C < D);
  assert (D < E);
  assert (E < F);
  assert (F < G);
  assert (G < H);
  assert (H < I);
  assert (I < J);
  assert (J < K);
  assert (K < L);
  assert (L < M);
  assert (M < N);
  assert (N < O);
  assert (O < P);
  assert (P < Q);
  assert (Q < R);
  assert (R < S);
  assert (S < T);
  assert (T < U);
  assert (U < V);
  assert (V < W);
  return 0;
}
