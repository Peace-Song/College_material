%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%{
#if defined __clang__ && 10 <= __clang_major__
# pragma clang diagnostic ignored "-Wdocumentation"
#endif

#include <stdio.h>

static void yyerror (const char *msg);
static int yylex (void);
%}
%define parse.error detailed
%token MYEOF 0 "end of file"
%token 'a' "a"  // Bison managed, when fed with '%token 'f' "f"' to #define 'f'!
%token B_TOKEN "b"
%token C_TOKEN 'c'
%token 'd' D_TOKEN
%token SPECIAL "\\\'\?\"\a\b\f\n\r\t\v\001\201\x001\x000081??!"
%token SPECIAL "\\\'\?\"\a\b\f\n\r\t\v\001\201\x001\x000081??!"
%%
exp: "∃¬∩∪∀";
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
#include <stdlib.h> /* getenv. */
#include <string.h> /* strcmp. */
int
main (int argc, char const* argv[])
{
  (void) argc;
  (void) argv;
  return yyparse ();
}
