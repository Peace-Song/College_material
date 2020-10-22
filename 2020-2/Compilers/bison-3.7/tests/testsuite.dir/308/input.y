%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%locations
%debug
%skeleton "yacc.c"
%define api.pure %parse-param { int x }

%code
{
# include <stdio.h>
# include <stdlib.h> /* getenv */
#include <stdio.h>

#if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
static int location_print (FILE *yyo, YYLTYPE const * const yylocp);
# ifndef LOCATION_PRINT
#  define LOCATION_PRINT(File, Loc) location_print (File, &(Loc))
# endif
#endif

static void yyerror (YYLTYPE const * const llocp, int x, const char *msg);
static int yylex (YYSTYPE *lvalp, YYLTYPE *llocp);
}
%%
exp: { LOCATION_PRINT(stderr, @$); fputc ('\n', stderr); }
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
void yyerror (YYLTYPE const * const llocp, int x, const char *msg)
{
  YYUSE (x);
  LOCATION_PRINT (stderr, (*llocp));
  fprintf (stderr, ": ");
  fprintf (stderr, "%s\n", msg);
}

int yylex (YYSTYPE *lvalp, YYLTYPE *llocp)
{
  YYUSE(lvalp);
  YYUSE(llocp);
  return 'x';
}

int
main (void)
{
  yydebug = !!getenv ("YYDEBUG");
  return !!yyparse (0);
}
