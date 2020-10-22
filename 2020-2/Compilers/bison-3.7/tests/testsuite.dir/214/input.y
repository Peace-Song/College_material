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



%glr-parser

%define parse.error verbose

%%

%nonassoc 'a';

// If $$ = 0 here, then we know that the 'a' destructor is being invoked
// incorrectly for the 'b' set in the semantic action below.  All 'a'
// tokens are returned by yylex, which sets $$ = 1.
%destructor {
  if (!$$)
    fprintf (stderr, "Wrong destructor.\n");
} 'a';

// Rather than depend on an inconsistent state to induce reading a
// lookahead as in the previous grammar, just assign the lookahead in a
// semantic action.  That lookahead isn't needed before either error
// action is encountered.  In a previous version of Bison, this was a
// problem as it meant yychar was not translated into yytoken before
// either error action.  The second error action thus invoked a
// destructor that it selected according to the incorrect yytoken.  The
// first error action would have reported an incorrect unexpected token
// except that, due to the bug described in the previous grammar, the
// unexpected token was not reported at all.
start: error-reduce consistent-error 'a' { USE ($3); } ;

error-reduce:
  'a' 'a' consistent-reduction consistent-error 'a'
  { USE (($1, $2, $5)); }
| 'a' error
  { USE ($1); }
;

consistent-reduction: %empty
{
  assert (yychar == YYEMPTY);
  yylval = 0;
  yychar = 'b';
} ;

consistent-error:
  'a' { USE ($1); }
| %empty %prec 'a'
;

// Provide another context in which all rules are useful so that this
// test case looks a little more realistic.
start: 'b' consistent-error 'b' ;



%%
#include <assert.h>
static
int yylex (YYSTYPE *lvalp)
{
  static char const input[] = "aa";
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
