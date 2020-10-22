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

%define lr.type lalr
%left 'a'
// Conflict resolution renders state 12 unreachable for canonical LR(1).  We
// keep it so that the parser table diff is easier to code.
%define lr.keep-unreachable-state

%%


S: 'a' A 'a' /* rule 1 */
 | 'b' A 'b' /* rule 2 */
 | 'c' c     /* rule 3 */
 ;

/* A conflict should appear after the first 'a' in rules 4 and 5 but only after
   having shifted the first 'a' in rule 1.  However, when LALR(1) merging is
   chosen, the state containing that conflict is reused after having seen the
   first 'b' in rule 2 and then the first 'a' in rules 4 and 5.  In both cases,
   because of the merged state, if the next token is an 'a', the %left forces a
   reduction action with rule 5.  In the latter case, only a shift is actually
   grammatically correct.  Thus, the parser would report a syntax error for the
   grammatically correct sentence "baab" because it would encounter a syntax
   error after that incorrect reduction.

   Despite not being LALR(1), Menhir version 20070322 suffers from this problem
   as well.  It uses David Pager's weak compatibility test for merging states.
   Bison and Menhir accept non-LR(1) grammars with conflict resolution.  Pager
   designed his algorithm only for LR(1) grammars.  */
A: 'a' 'a' /* rule 4 */
 | 'a'     /* rule 5 */
 ;

/* Rule 3, rule 6, and rule 7 ensure that Bison does not report rule 4 as
   useless after conflict resolution.  This proves that, even though LALR(1)
   generates incorrect parser tables sometimes, Bison will not necessarily
   produce any warning to help the user realize it.  */
c: 'a' 'b' /* rule 6 */
 | A       /* rule 7 */
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
    'b', 'a', 'a', 'b', 0
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
