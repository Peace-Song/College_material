%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%debug

%code
{
# include <stdio.h>
# include <stdlib.h>
#include <stdio.h>

static void yyerror (const char *msg);
static int yylex (void);
}

%skeleton "yacc.c"
           %define api.value.type {struct bar}
%code requires
           {
             struct u
             {
               int ival;
             };
             struct bar
             {
               struct u *up;
             };
           }
           %token <up->ival> '1' '2'
           %printer { fprintf (yyo, "%d", $$); } <up->ival>


%%

start: '1' '2'
           {
             printf ("%d %d\n", $1, $<up->ival>2);
             free ($<up>1);
             free ($<up>2);
           };

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
  static char const input[] = "12";
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  if (res)
             {
               (yylval).up = YY_CAST (struct u *, malloc (sizeof *(yylval).up));
               assert ((yylval).up);
               (yylval).up->ival = res - '0';
             }
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
