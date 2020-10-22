%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%{
  #include <assert.h>
  #include <stdio.h>
  #define YYINITDEPTH 1
#include <stdio.h>

static void yyerror (const char *msg);
%}

%define api.pure
%define api.push-pull push

%%

start: 'a' 'b' 'c' ;

%%





/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}

int
main (void)
{
  yypstate *ps;

  /* Make sure we don't try to free ps->yyss in this case.  */
  ps = yypstate_new ();
  yypstate_delete (ps);

  /* yypstate_delete used to leak ps->yyss if the stack was reallocated but the
     parse did not return on success, syntax error, or memory exhaustion.  */
  ps = yypstate_new ();
  assert (yypush_parse (ps, 'a', YY_NULLPTR) == YYPUSH_MORE);
  yypstate_delete (ps);

  ps = yypstate_new ();
  assert (yypush_parse (ps, 'a', YY_NULLPTR) == YYPUSH_MORE);
  assert (yypush_parse (ps, 'b', YY_NULLPTR) == YYPUSH_MORE);
  yypstate_delete (ps);

  return 0;
}
