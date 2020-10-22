%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%define parse.assert
%glr-parser
%define parse.error verbose
%expect-rr 1
%code requires
{
  #include <assert.h>
  #include <stdbool.h>
  bool new_syntax = false;
  const char *input = YY_NULLPTR;
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
}
%%
widget:
  %? {new_syntax} 'w' id new_args  { printf("new"); }
| %?{!new_syntax} 'w' id old_args  { printf("old"); }
;
id: 'i';
new_args: 'n';
old_args: 'o';
%%




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}

int
yylex (void)
{
  return *input++;
}

int
main (int argc, const char* argv[])
{
  assert (argc == 2); (void) argc;
  // First char decides whether new, or old syntax.
  // Then the input.
  new_syntax = argv[1][0] == 'N';
  input = argv[1] + 1;
  return yyparse ();
}
