%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%code {
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
}

%left 'a'
// Conflict resolution renders state 16 unreachable for canonical LR(1).  We
// keep it so that the parser table diff is easier to code.
%define lr.keep-unreachable-state

%%


/* Similar to the last test case set but forseeing the S/R conflict from the
   first state that must be split is becoming difficult.  Imagine if B were
   even more complex.  Imagine if A had other RHS's ending in other
   nonterminals.  */
S: 'a' A 'a'
 | 'b' A 'b'
 | 'c' c
 ;
A: 'a' 'a' B
 ;
B: 'a'
 | %empty %prec 'a'
 ;
c: 'a' 'a' 'b'
 | A
 ;


%%




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
static int
yylex (void)
{
  static int const input[] = {
    'b', 'a', 'a', 'a', 'b', 0
  };
  static int const *inputp = input;
  return *inputp++;
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
