%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%skeleton "yacc.c"
%debug
%code requires
{
  typedef struct sem_type
  {
    int ival;
    float fval;
  } sem_type;

# define YYSTYPE sem_type


# include <stdio.h>
  static void
  report (FILE* yyo, int ival, float fval)
  {
    fprintf (yyo, "ival: %d, fval: %1.1f", ival, fval);
  }

}

%code
{
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
}

%token UNTYPED
%token <ival> INT
%type <fval> float
%printer { report (yyo, $$,       $<fval>$); } <ival>;
%printer { report (yyo, $<ival>$, $$      ); } <fval>;
%printer { report (yyo, $<ival>$, $<fval>$); } <>;

%initial-action
{
  $<ival>$ = 42;
  $<fval>$ = 4.2f;
}

%%
float: UNTYPED INT
{
  $$       = $<fval>1 + $<fval>2;
  $<ival>$ = $<ival>1 + $2;
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
  static int const input[] = {UNTYPED, INT, EOF};
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  (yylval).ival = toknum * 10;
                  (yylval).fval = YY_CAST (float, toknum) / 10.0f;;

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
