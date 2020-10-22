%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%code {
  #include <assert.h>
  #include <stdio.h>
#include <stdio.h>

static void yyerror (const char *msg);
static int yylex (void);
  #define USE(Var)
}

%destructor { fprintf (stderr, "'a' destructor\n"); } 'a'
%destructor { fprintf (stderr, "'b' destructor\n"); } 'b'

%%

// In a previous version of Bison, yychar assigned by the semantic
// action below was not translated into yytoken before the lookahead was
// discarded and thus before its destructor (selected according to
// yytoken) was called in order to return from yyparse.  This would
// happen even if YYACCEPT was performed in a later semantic action as
// long as only consistent states with default reductions were visited
// in between.  However, we leave YYACCEPT in the same semantic action
// for this test in order to show that skeletons cannot simply translate
// immediately after every semantic action because a semantic action
// that has set yychar might not always return normally.  Instead,
// skeletons must translate before every use of yytoken.
start: 'a' accept { USE($1); } ;
accept: %empty {
  assert (yychar == YYEMPTY);
  yychar = 'b';
  YYACCEPT;
} ;

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
  static char const input[] = "a";
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
