%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%define parse.error verbose
%debug
%define api.pure
%code {
# include <stdio.h>
# include <stdlib.h>
# include <assert.h>

  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (YYSTYPE *lvalp);
}
%%
input:
  exp exp {}
;

exp:
  'a'     { printf ("a: %d\n", $1); }
| 'b'     { YYBACKUP('a', 123); }
| 'c' 'd' { YYBACKUP('a', 456); }
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
int yylex (YYSTYPE *lvalp)
{
  static char const input[] = "bcd";
  static int toknum = 0;
  int res;
  (void) lvalp;
  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  *lvalp = (toknum + 1) * 10;

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
