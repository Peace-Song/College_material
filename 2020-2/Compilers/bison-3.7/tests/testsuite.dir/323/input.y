%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%code requires {
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define YYINITDEPTH 10
#define YYMAXDEPTH 10
#define RANGE(Location) (Location).first_line, (Location).last_line

#define USE(SYM)

/* Display the symbol type Symbol.  */
#define V(Symbol, Value, Location, Sep) \
   fprintf (stderr, #Symbol " (%d@%d-%d)%s", Value, RANGE(Location), Sep)
}

%define parse.error verbose
%debug
%verbose
%locations

%union
{
  int ival;
}
%code provides {

static int yylex (void);
#include <stdio.h>

#if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
static int location_print (FILE *yyo, YYLTYPE const * const yylocp);
# ifndef LOCATION_PRINT
#  define LOCATION_PRINT(File, Loc) location_print (File, &(Loc))
# endif
#endif

static void yyerror (const char *msg);
}

%type <ival> '(' 'x' 'y' ')' ';' thing line input
              '!' raise check-spontaneous-errors END

/* FIXME: This %printer isn't actually tested.  */
%printer
  {
    fprintf (yyo, "%d", $$);
  }
  '(' 'x' 'y' ')' ';' thing line input '!' raise check-spontaneous-errors END

%destructor
  { fprintf (stderr, "Freeing nterm input (%d@%d-%d)\n", $$, RANGE (@$)); }
  input

%destructor
  { fprintf (stderr, "Freeing nterm line (%d@%d-%d)\n", $$, RANGE (@$)); }
  line

%destructor
  { fprintf (stderr, "Freeing nterm thing (%d@%d-%d)\n", $$, RANGE (@$)); }
  thing

%destructor
  { fprintf (stderr, "Freeing nterm raise (%d@%d-%d)\n", $$, RANGE (@$)); }
  raise

%destructor
  { fprintf (stderr, "Freeing nterm check-spontaneous-errors (%d@%d-%d)\n", $$, RANGE (@$)); }
  check-spontaneous-errors

%destructor
  { fprintf (stderr, "Freeing token 'x' (%d@%d-%d)\n", $$, RANGE (@$)); }
  'x'

%destructor
  { fprintf (stderr, "Freeing token 'y' (%d@%d-%d)\n", $$, RANGE (@$)); }
  'y'

%token END 0
%destructor
  { fprintf (stderr, "Freeing token END (%d@%d-%d)\n", $$, RANGE (@$)); }
  END

%%
/*
   This grammar is made to exercise error recovery.
   "Lines" starting with '(' support error recovery, with
   ')' as synchronizing token.  Lines starting with 'x' can never
   be recovered from if in error.
*/

input:
  %empty
    {
      $$ = 0;
      V(input, $$, @$, ": /* Nothing */\n");
    }
| line input /* Right recursive to load the stack so that popping at
                END can be exercised.  */
    {
      $$ = 2;
      V(input, $$, @$, ": ");
      V(line,  $1, @1, " ");
      V(input, $2, @2, "\n");
    }
| '!' check-spontaneous-errors
  {
    $$ = $2;
  }
;

check-spontaneous-errors:
  raise         { abort(); USE(($$, $1)); }
| '(' raise ')' { abort(); USE(($$, $2)); }
| error
  {
    $$ = 5;
    V(check-spontaneous-errors, $$, @$, ": ");
    fprintf (stderr, "error (@%d-%d)\n", RANGE(@1));
  }
;

raise:
  %empty
  {
    $$ = 4;
    V(raise, $$, @$, ": %empty\n");
    YYERROR;
  }
| '!' '!'
  {
    $$ = 5;
    V(raise, $$, @$, ": ");
    V(!, $1, @2, " ");
    V(!, $2, @2, "\n");
    YYERROR;
  }
;

line:
  thing thing thing ';'
    {
      $$ = $1;
      V(line,  $$, @$, ": ");
      V(thing, $1, @1, " ");
      V(thing, $2, @2, " ");
      V(thing, $3, @3, " ");
      V(;,     $4, @4, "\n");
    }
| '(' thing thing ')'
    {
      $$ = $1;
      V(line,  $$, @$, ": ");
      V('(',   $1, @1, " ");
      V(thing, $2, @2, " ");
      V(thing, $3, @3, " ");
      V(')',   $4, @4, "\n");
    }
| '(' thing ')'
    {
      $$ = $1;
      V(line,  $$, @$, ": ");
      V('(',   $1, @1, " ");
      V(thing, $2, @2, " ");
      V(')',   $3, @3, "\n");
    }
| '(' error ')'
    {
      $$ = -1;
      V(line,  $$, @$, ": ");
      V('(',   $1, @1, " ");
      fprintf (stderr, "error (@%d-%d) ", RANGE(@2));
      V(')',   $3, @3, "\n");
    }
;

thing:
  'x'
    {
      $$ = $1;
      V(thing, $$, @$, ": ");
      V('x',   $1, @1, "\n");
    }
;
%%
/* Alias to ARGV[1]. */
const char *source = YY_NULLPTR;


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

static
int yylex (void)
{
  static int counter = 0;

  int c = (yylval).ival = counter++;
  assert (c <= YY_CAST (int, strlen (source)));
  /* As in BASIC, line numbers go from 10 to 10.  */
  (yylloc).first_line = (yylloc).first_column = (10 * c);
  (yylloc).last_line = (yylloc).last_column = (yylloc).first_line + 9;
  if (source[c])
    fprintf (stderr, "sending: '%c'", source[c]);
  else
    fprintf (stderr, "sending: END");
  fprintf (stderr, " (%d@%d-%d)\n", c, RANGE ((yylloc)));
  return source[c];
}



int
main (int argc, const char *argv[])
{
  int status;
  yydebug = !!getenv ("YYDEBUG");
  assert (argc == 2); (void) argc;
  source = argv[1];
  status = yyparse ();
  switch (status)
    {
      case 0: fprintf (stderr, "Successful parse.\n"); break;
      case 1: fprintf (stderr, "Parsing FAILED.\n"); break;
      default: fprintf (stderr, "Parsing FAILED (status %d).\n", status); break;
    }
  return status;
}
