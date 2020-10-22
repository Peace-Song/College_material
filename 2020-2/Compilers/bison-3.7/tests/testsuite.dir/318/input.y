%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%locations
%debug
%skeleton "glr.c"


%code
{
#include <stdio.h> /* putchar. */
#include <stdio.h>

#if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
static int location_print (FILE *yyo, YYLTYPE const * const yylocp);
# ifndef LOCATION_PRINT
#  define LOCATION_PRINT(File, Loc) location_print (File, &(Loc))
# endif
#endif

static void yyerror (const char *msg);
static int yylex (void);
}
%%
exp: %empty;
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
  static char const input[] = "";
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  ;

  (yylloc).first_line = (yylloc).last_line = 1;
  (yylloc).first_column = (yylloc).last_column = toknum;
  return res;
}

int
main (void)
{
  YYLTYPE loc;

#define TEST(L1, C1, L2, C2)          \
  loc.first_line = L1;           \
  loc.first_column = C1;         \
  loc.last_line = L2;            \
  loc.last_column = C2;          \
  LOCATION_PRINT(stdout, loc);\
  putchar ('\n');

  TEST(1, 1, 1, 1);
  TEST(2, 1, 2, 10);
  TEST(3, 1, 4, 1);
  TEST(5, 1, 6, 10);

  TEST(7, 2, 0, 2);
  TEST(8, 0, 8, 0);
  return 0;
}
