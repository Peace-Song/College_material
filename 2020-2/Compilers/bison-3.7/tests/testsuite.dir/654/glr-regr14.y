%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


/* Tests:
     - Conflicting actions (split-off parse, which copies lookahead need,
       which is necessarily yytrue) and nonconflicting actions (non-split-off
       parse) for nondefaulted state: yychar != YYEMPTY.
     - Merged deferred actions (lookahead need and RHS from different stack
       than the target state) and nonmerged deferred actions (same stack).
     - Defaulted state after lookahead: yychar != YYEMPTY.
     - Defaulted state after shift: yychar == YYEMPTY.
     - yychar != YYEMPTY but lookahead need is yyfalse (a previous stack has
       seen the lookahead but current stack has not).
     - Exceeding stack capacity (stack explosion), and thus reallocating
       lookahead need array.
   Note that it does not seem possible to see the initial yychar value during
   nondeterministic operation since:
     - In order to preserve the initial yychar, only defaulted states may be
       entered.
     - If only defaulted states are entered, there are no conflicts, so
       nondeterministic operation does not start.  */

%union { char value; }

%{
  #include <stdlib.h>
  #include <stdio.h>
  #include <assert.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
  static void print_lookahead (char const *);
  static char merge (union YYSTYPE, union YYSTYPE);
  #define USE(value)
%}

%define parse.assert
%type <value> 'a' 'b' 'c' 'd' stack_explosion
%glr-parser
%locations

%%

start:
  merge 'c' stack_explosion {
    USE ($2); USE ($3);
    print_lookahead ("start <- merge 'c' stack_explosion");
  }
  ;

/* When merging the 2 deferred actions, the lookahead needs are different.  */
merge:
  nonconflict1 'a' 'b' nonconflict2 %dprec 1 {
    USE ($2); USE ($3);
    print_lookahead ("merge <- nonconflict1 'a' 'b' nonconflict2");
  }
  | conflict defstate_look 'a' nonconflict2 'b' defstate_shift %dprec 2 {
    USE ($3); USE ($5);
    print_lookahead ("merge <- conflict defstate_look 'a' nonconflict2 'b'"
                      " defstate_shift");
  }
  ;

nonconflict1:
  {
    print_lookahead ("nonconflict1 <- empty string");
  }
  ;
nonconflict2:
  {
    print_lookahead ("nonconflict2 <- empty string");
  }
  | 'a' {
    USE ($1);
    print_lookahead ("nonconflict2 <- 'a'");
  }
  ;
conflict:
  {
    print_lookahead ("conflict <- empty string");
  }
  ;
defstate_look:
  {
    print_lookahead ("defstate_look <- empty string");
  }
  ;

/* yychar != YYEMPTY but lookahead need is yyfalse.  */
defstate_shift:
  {
    print_lookahead ("defstate_shift <- empty string");
  }
  ;

stack_explosion:
  { $$ = '\0'; }
  | alt1 stack_explosion %merge<merge> { $$ = $2; }
  | alt2 stack_explosion %merge<merge> { $$ = $2; }
  | alt3 stack_explosion %merge<merge> { $$ = $2; }
  ;
alt1:
  'd' no_look {
    USE ($1);
    if (yychar != 'd' && yychar != YYEOF)
      {
        fprintf (stderr, "Incorrect lookahead during stack explosion.\n");
      }
  }
  ;
alt2:
  'd' no_look {
    USE ($1);
    if (yychar != 'd' && yychar != YYEOF)
      {
        fprintf (stderr, "Incorrect lookahead during stack explosion.\n");
      }
  }
  ;
alt3:
  'd' no_look {
    USE ($1);
    if (yychar != 'd' && yychar != YYEOF)
      {
        fprintf (stderr, "Incorrect lookahead during stack explosion.\n");
      }
  }
  ;
no_look:
  {
    if (yychar != YYEMPTY)
      {
        fprintf (stderr,
                 "Found lookahead where shouldn't during stack explosion.\n");
      }
  }
  ;

%%





/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
static int
yylex (void)
{
  static char const input[] = "abcdddd";
  static int toknum = 0;
  assert (toknum < YY_CAST (int, sizeof input));
  yylloc.first_line = yylloc.last_line = 1;
  yylloc.first_column = yylloc.last_column = toknum + 1;
  yylval.value = YY_CAST (char, input[toknum] + 'A' - 'a');
  return input[toknum++];
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

static char
merge (union YYSTYPE s1, union YYSTYPE s2)
{
  return YY_CAST (char, s1.value + s2.value);
}

int
main (void)
{
  yychar = '#'; /* Not a token in the grammar.  */
  yylval.value = '!';
  return yyparse ();
}
