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

%define parse.error verbose
%nonassoc 'a'

%%

start:
  'a' problem 'a' // First context.
| 'b' problem 'b' // Second context.
| 'c' reduce-nonassoc // Just makes reduce-nonassoc useful.
;

problem:
  look reduce-nonassoc
| look 'a'
| look 'b'
;

// For the state reached after shifting the 'a' in these productions,
// lookahead sets are the same in both the first and second contexts.
// Thus, canonical LR reuses the same state for both contexts.  However,
// the lookahead 'a' for the reduction "look: 'a'" later becomes an
// error action only in the first context.  In order to immediately
// detect the syntax error on 'a' here for only the first context, this
// canonical LR state would have to be split into two states, and the
// 'a' lookahead would have to be removed from only one of the states.
look:
  'a' // Reduction lookahead set is always ['a', 'b'].
| 'a' 'b'
| 'a' 'c' // 'c' is forgotten as an expected token.
;

reduce-nonassoc: %prec 'a';

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
  static char const input[] = "aaa";
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  ;

  return res;
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
