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

static void yyerror (const char *msg);
  static int yylex (YYSTYPE *lvalp);
  #define USE(Var)
}

%define api.pure


%code {
  #if defined __GNUC__ && 8 <= __GNUC__
  # pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
  #endif
}


%define lr.type ielr
                             %define lr.default-reduction consistent

%define parse.error verbose

%%

%nonassoc 'a';

start: consistent-error-on-a-a 'a' ;

consistent-error-on-a-a:
    'a' default-reduction
  | 'a' default-reduction 'a'
  | 'a' shift
  ;

default-reduction: %empty ;
shift: 'b' ;

// Provide another context in which all rules are useful so that this
// test case looks a little more realistic.
start: 'b' consistent-error-on-a-a 'c' ;



%%
#include <assert.h>
static
int yylex (YYSTYPE *lvalp)
{
  static char const input[] = "a";
  static int toknum = 0;
  int res;
  (void) lvalp;
  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  *lvalp = 1;

  return res;
}




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}


/*-------.
| main.  |
`-------*/
#include <stdlib.h> /* getenv. */
#include <string.h> /* strcmp. */
int
main (int argc, char const* argv[])
{
  (void) argc;
  (void) argv;
  return yyparse ();
}
