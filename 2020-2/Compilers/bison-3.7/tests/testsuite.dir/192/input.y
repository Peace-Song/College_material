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

%define lr.default-reduction consistent

%%


/* The start state is consistent and has a shift on 'a' and no reductions.
   After pushing the b below, enter an inconsistent state that has a shift and
   one reduction with one lookahead.  */
start:
    a b
  | a b 'a'
  | a c 'b'
  ;

/* After shifting this 'a', enter a consistent state that has no shift and 1
   reduction with multiple lookaheads.  */
a: 'a' ;

/* After the previous reduction, enter an inconsistent state that has no shift
   and multiple reductions.  The first reduction has more lookaheads than the
   second, so the first should always be preferred as the default reduction if
   enabled.  The second reduction has one lookahead.  */
b: %empty;
c: %empty;


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
    'a', 'a', 0
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
