%code top { /* -*- c++ -*- */
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
#define RANGE(Location) (Location).begin.line, (Location).end.line

#define USE(SYM)

/* Display the symbol type Symbol.  */
#define V(Symbol, Value, Location, Sep) \
   fprintf (stderr, #Symbol " (%d@%d-%d)%s", Value, RANGE(Location), Sep)
}

%define parse.error verbose
%debug
%verbose
%locations
%defines %skeleton "glr.cc"

%code {

static int yylex (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp);

}



/* FIXME: This %printer isn't actually tested.  */
%printer
  {
    yyo << $$;;
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

/* A C++ error reporting function.  */
void
yy::parser::error (const location_type& l, const std::string& m)
{
  std::cerr << l << ": " << m << '\n';
}

static
int yylex (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp)
{
  static int counter = 0;

  int c = (*lvalp) = counter++;
  assert (c <= YY_CAST (int, strlen (source)));
  /* As in BASIC, line numbers go from 10 to 10.  */
  (*llocp).begin.line = (*llocp).begin.column = (10 * c);
  (*llocp).end.line = (*llocp).end.column = (*llocp).begin.line + 9;
  if (source[c])
    fprintf (stderr, "sending: '%c'", source[c]);
  else
    fprintf (stderr, "sending: END");
  fprintf (stderr, " (%d@%d-%d)\n", c, RANGE ((*llocp)));
  return source[c];
}

int
yyparse ()
{
  yy::parser parser;
  parser.set_debug_level (yydebug);
  return parser.parse ();
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
