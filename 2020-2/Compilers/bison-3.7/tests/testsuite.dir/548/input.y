%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%{
#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#define YYSTACK_USE_ALLOCA 0
  static int yylex (void);
  #include <stdio.h>

static void yyerror (const char *msg);
%}

%define parse.error verbose
%token WAIT_FOR_EOF
%%
exp: WAIT_FOR_EOF exp | %empty;
%%




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
#include <assert.h>
static int
yylex (void)
{
  assert (0 <= yylval);
  if (yylval--)
    return WAIT_FOR_EOF;
  else
    return EOF;
}

/* Return argv[1] as an int. */
static int
get_args (int argc, const char **argv)
{
  long res;
  char *endp;
  assert (argc == 2); (void) argc;
  res = strtol (argv[1], &endp, 10);
  assert (argv[1] != endp);
  assert (0 <= res);
  assert (res <= INT_MAX);
  assert (errno != ERANGE);
  return YY_CAST (int, res);
}

int
main (int argc, const char **argv)
{
  YYSTYPE yylval_init = get_args (argc, argv);
  int status = 0;
  int count;

  for (count = 0; count < 2; ++count)
    {
      int new_status;
      yylval = yylval_init;
      new_status = yyparse ();
      if (count == 0)
        status = new_status;
      else
        assert (new_status == status);
    }
  return status;
}
