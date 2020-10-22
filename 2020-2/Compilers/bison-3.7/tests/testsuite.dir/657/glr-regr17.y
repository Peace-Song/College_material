%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%define parse.assert
%glr-parser
%locations
%define api.pure
%define parse.error verbose

%union { int dummy; }

%{
  #include <stdio.h>

#if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
static int location_print (FILE *yyo, YYLTYPE const * const yylocp);
# ifndef LOCATION_PRINT
#  define LOCATION_PRINT(File, Loc) location_print (File, &(Loc))
# endif
#endif

static void yyerror (YYLTYPE const * const llocp, const char *msg);
  static int yylex (YYSTYPE *lvalp, YYLTYPE *llocp);
%}

%%

/* Tests the case of an empty RHS that has inherited the location of the
   previous nonterminal, which is unresolved.  That location is reported as the
   last position of the ambiguity.  */
start: ambig1 empty1 | ambig2 empty2 ;

/* Tests multiple levels of yyresolveLocations recursion.  */
ambig1: sub_ambig1 | sub_ambig2 ;
ambig2: sub_ambig1 | sub_ambig2 ;

/* Tests the case of a non-empty RHS as well as the case of an empty RHS that
   has inherited the initial location.  The empty RHS's location is reported as
   the first position in the ambiguity.  */
sub_ambig1: empty1 'a' 'b' ;
sub_ambig2: empty2 'a' 'b' ;
empty1: ;
empty2: ;

%%
# include <assert.h>


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
void yyerror (YYLTYPE const * const llocp, const char *msg)
{
  LOCATION_PRINT (stderr, (*llocp));
  fprintf (stderr, ": ");
  fprintf (stderr, "%s\n", msg);
}
static int
yylex (YYSTYPE *lvalp, YYLTYPE *llocp)
{
  static char const input[] = "ab";
  static int toknum = 0;
  assert (toknum < YY_CAST (int, sizeof input));
  lvalp->dummy = 0;
  llocp->first_line = llocp->last_line = 2;
  llocp->first_column = toknum + 1;
  llocp->last_column = llocp->first_column + 1;
  return input[toknum++];
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
