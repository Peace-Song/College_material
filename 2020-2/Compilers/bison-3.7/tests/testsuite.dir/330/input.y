%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%define parse.error verbose
%debug
%locations

%code {
static int yylex (void);
#include <stdio.h>

#if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
static int location_print (FILE *yyo, YYLTYPE const * const yylocp);
# ifndef LOCATION_PRINT
#  define LOCATION_PRINT(File, Loc) location_print (File, &(Loc))
# endif
#endif

static void yyerror (const char *msg);
# define USE(SYM)
}

%printer {
  #error "<*> printer should not be used."
} <*>

%printer {
  fprintf (yyo, "<> printer for '%c' @ %d", $$, @$.first_column);
} <>
%destructor {
  printf ("<> destructor for '%c' @ %d.\n", $$, @$.first_column);
} <>

%printer {
  fprintf (yyo, "'b'/'c' printer for '%c' @ %d", $$, @$.first_column);
} 'b' 'c'
%destructor {
  printf ("'b'/'c' destructor for '%c' @ %d.\n", $$, @$.first_column);
} 'b' 'c'

%destructor {
  #error "<*> destructor should not be used."
} <*>

%%

start: 'a' 'b' 'c' 'd' 'e' { $$ = 'S'; USE(($1, $2, $3, $4, $5)); } ;

%%

# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
/* Print *YYLOCP on YYO. */
__attribute__((__unused__))
static int
location_print (FILE *yyo, YYLTYPE const * const yylocp)
{
  int res = 0;
  int end_col = 0 != yylocp->last_column ? yylocp->last_column - 1 : 0;
  if (0 <= yylocp->first_line)
    {
      res += fprintf (yyo, "%d", yylocp->first_line);
      if (0 <= yylocp->first_column)
        res += fprintf (yyo, ".%d", yylocp->first_column);
    }
  if (0 <= yylocp->last_line)
    {
      if (yylocp->first_line < yylocp->last_line)
        {
          res += fprintf (yyo, "-%d", yylocp->last_line);
          if (0 <= end_col)
            res += fprintf (yyo, ".%d", end_col);
        }
      else if (0 <= end_col && yylocp->first_column < end_col)
        res += fprintf (yyo, "-%d", end_col);
    }
  return res;
}
#endif




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  LOCATION_PRINT (stderr, (yylloc));
  fprintf (stderr, ": ");
  fprintf (stderr, "%s\n", msg);
}
#include <assert.h>
static
int yylex (void)
{
  static char const input[] = "abcd";
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  yylval = res;

  (yylloc).first_line = (yylloc).last_line = 1;
  (yylloc).first_column = (yylloc).last_column = toknum;
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
