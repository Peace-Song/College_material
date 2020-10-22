%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%define parse.error verbose
%debug

%{
#include <stdio.h>

static void yyerror (const char *msg);
static int yylex (void);
# define USE(SYM)
%}

%printer {
  #error "<> printer should not be used."
} <>

%union { int field0; int field1; int field2; }
%type <field0> start 'a' 'g'
%type <field1> 'e'
%type <field2> 'f'
%printer {
  fprintf (yyo, "<*>/<field2>/e printer");
} <*> 'e' <field2>
%destructor {
  printf ("<*>/<field2>/e destructor.\n");
} <*> 'e' <field2>

%type <field1> 'b'
%printer { fprintf (yyo, "<field1> printer"); } <field1>
%destructor { printf ("<field1> destructor.\n"); } <field1>

%type <field0> 'c'
%printer { fprintf (yyo, "'c' printer"); } 'c'
%destructor { printf ("'c' destructor.\n"); } 'c'

%type <field1> 'd'
%printer { fprintf (yyo, "'d' printer"); } 'd'
%destructor { printf ("'d' destructor.\n"); } 'd'

%destructor {
  #error "<> destructor should not be used."
} <>

%%

start:
  'a' 'b' 'c' 'd' 'e' 'f' 'g'
    {
      USE(($1, $2, $3, $4, $5, $6, $7));
      $$ = 'S';
    }
  ;

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
  static char const input[] = "abcdef";
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
