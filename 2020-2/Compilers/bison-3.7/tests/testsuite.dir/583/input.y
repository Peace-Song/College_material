%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%code {
#include <stdio.h> /* printf */
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
}
%debug
%define api.push-pull pull
%define parse.error verbose
%token 'c'
%expect 21
%%

// default reductions in inconsistent states
// v   v v   v v v v   v v v v v v v
S: A B A A B A A A A B A A A A A A A B C C A A A A A A A A A A A A B ;
//       ^                     ^                               ^
// LAC reallocs

A: 'a' | %empty { printf ("inconsistent default reduction\n"); } ;
B: 'b' ;
C: %empty { printf ("consistent default reduction\n"); } ;

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
  static char const input[] = "bbbbc";
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
  yydebug = !!getenv ("YYDEBUG");
  for (int i = 1; i < argc; ++i)
    if (!strcmp (argv[i], "-p")
        || !strcmp (argv[i], "-d") || !strcmp (argv[i], "--debug"))
      yydebug |= 1;
    else if (!strcmp (argv[i], "-s") || !strcmp (argv[i], "--stat"))
      yydebug |= 2;
  return yyparse ();
}
