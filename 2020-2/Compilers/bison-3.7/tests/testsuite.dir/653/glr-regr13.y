%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


/* Tests:
     - Defaulted state with initial yychar: yychar == YYEMPTY.
     - Nondefaulted state: yychar != YYEMPTY.
     - Defaulted state after lookahead: yychar != YYEMPTY.
     - Defaulted state after shift: yychar == YYEMPTY.
     - User action changing the lookahead.  */

%{
  #include <stdio.h>
  #include <assert.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
  static void print_lookahead (char const *);
  #define USE(value)
%}

%define parse.assert
%union { char value; }
%type <value> 'a' 'b'
%glr-parser
%locations

%%

start:
  defstate_init defstate_shift 'b' change_lookahead 'a' {
    USE ($3);
    print_lookahead ("start <- defstate_init defstate_shift 'b'");
  }
  ;
defstate_init:
  {
    print_lookahead ("defstate_init <- empty string");
  }
  ;
defstate_shift:
  nondefstate defstate_look 'a' {
    USE ($3);
    print_lookahead ("defstate_shift <- nondefstate defstate_look 'a'");
  }
  ;
defstate_look:
  {
    print_lookahead ("defstate_look <- empty string");
  }
  ;
nondefstate:
  {
    print_lookahead ("nondefstate <- empty string");
  }
  | 'b' {
    USE ($1);
    print_lookahead ("nondefstate <- 'b'");
  }
  ;
change_lookahead:
  {
    yychar = 'a';
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
  static char const input[] = "ab";
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  yylval.value = YY_CAST (char, res + 'A' - 'a');

  return res;
}

static void
print_lookahead (char const *reduction)
{
  printf ("%s:\n  yychar=", reduction);
  if (yychar == YYEMPTY)
    printf ("YYEMPTY");
  else if (yychar == YYEOF)
    printf ("YYEOF");
  else
    {
      printf ("'%c', yylval='", yychar);
      if (yylval.value > ' ')
        printf ("%c", yylval.value);
      printf ("', yylloc=(%d,%d),(%d,%d)",
              yylloc.first_line, yylloc.first_column,
              yylloc.last_line, yylloc.last_column);
    }
  printf ("\n");
}

int
main (void)
{
  yychar = '#'; /* Not a token in the grammar.  */
  yylval.value = '!';
  return yyparse ();
}
