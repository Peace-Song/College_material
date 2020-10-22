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

%define lr.keep-unreachable-state

%%


/* The partial state chart diagram below is for LALR(1).  State 0 is the start
   state.  States are iterated for successor construction in numerical order.
   Transitions are downwards.

   State 13 has a R/R conflict that cannot be predicted by Bison's LR(1)
   algorithm using annotations alone.  That is, when state 11's successor on
   'd' is merged with state 5 (which is originally just state 1's successor on
   'd'), state 5's successor on 'e' must then be changed because the resulting
   lookaheads that propagate to it now make it incompatible with state 8's
   successor on 'e'.  In other words, state 13 must be split to avoid the
   conflict.

          0
        / | \
     a / c|  \ b
      1   3   2
      |   |   |
     d|   |c  | d
      |  11   |
      |   |   |
       \ /d   |
        5     8
         \    |
        e \  / e
           13
           R/R

   This grammar is designed carefully to make sure that, despite Bison's LR(1)
   algorithm's bread-first iteration of transitions to reconstruct states,
   state 11's successors are constructed after state 5's and state 8's.
   Otherwise (for example, if you remove the first 'c' in each of rules 6 and
   7), state 5's successor on 'e' would never be merged with state 8's, so the
   split of the resulting state 13 would never need to be performed.  */
S: 'a' A 'f'
 | 'a' B
 | 'b' A 'f'
 | 'b' B 'g'
 | 'b' 'd'
 | 'c' 'c' A 'g'
 | 'c' 'c' B
 ;
A: 'd' 'e' ;
B: 'd' 'e' ;


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
    'b', 'd', 'e', 'g', 0
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
