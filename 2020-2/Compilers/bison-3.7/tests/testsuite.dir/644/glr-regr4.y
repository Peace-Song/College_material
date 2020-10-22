%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%define parse.assert
%union { char *ptr; }
%type <ptr> S A A1 A2 B
%glr-parser

%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  static char *merge (YYSTYPE, YYSTYPE);
  static char *make_value (char const *, char const *);
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
  static char *ptrs[100];
  static char **ptrs_next = ptrs;
%}

%%

tree: S { printf ("%s\n", $1); } ;

S:
  A   %merge<merge> { $$ = make_value ("S", $1); }
  | B %merge<merge> { $$ = make_value ("S", $1); }
  ;

A:
  A1   %merge<merge> { $$ = make_value ("A", $1); }
  | A2 %merge<merge> { $$ = make_value ("A", $1); }
  ;

A1: 'a' { $$ = make_value ("A1", "'a'"); } ;
A2: 'a' { $$ = make_value ("A2", "'a'"); } ;
B:  'a' { $$ = make_value ("B", "'a'");  } ;

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
  static char const input[] = "a";
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  ;

  return res;
}

int
main (void)
{
  int status = yyparse ();
  while (ptrs_next != ptrs)
    free (*--ptrs_next);
  return status;
}

static char *
make_value (char const *parent, char const *child)
{
  char const format[] = "%s <- %s";
  char *value = *ptrs_next++ =
    YY_CAST (char *, malloc (strlen (parent) + strlen (child) + sizeof format));
  sprintf (value, format, parent, child);
  return value;
}

static char *
merge (YYSTYPE s1, YYSTYPE s2)
{
  char const format[] = "merge{ %s and %s }";
  char *value = *ptrs_next++ =
    YY_CAST (char *, malloc (strlen (s1.ptr) + strlen (s2.ptr) + sizeof format));
  sprintf (value, format, s1.ptr, s2.ptr);
  return value;
}
