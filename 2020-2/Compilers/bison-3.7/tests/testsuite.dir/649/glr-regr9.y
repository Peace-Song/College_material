%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%{
# include <stdio.h>
# include <stdlib.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
# define YYSTACKEXPANDABLE 0
  static int tokens = 0;
  static int destructors = 0;
# define USE(Var)
%}

%define parse.assert
%glr-parser
%union { int dummy; }
%type <dummy> 'a'

%destructor {
  destructors += 1;
} 'a'

%%

start:
    ambig0 'a'   { destructors += 2; USE ($2); }
  | ambig1 start { destructors += 1; }
  | ambig2 start { destructors += 1; }
  ;

ambig0: 'a' ;
ambig1: 'a' ;
ambig2: 'a' ;

%%

static int
yylex (void)
{
  tokens += 1;
  return 'a';
}





/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
int
main (void)
{
  int exit_status;
  exit_status = yyparse ();
  if (tokens != destructors)
    {
      fprintf (stderr, "Tokens = %d, Destructors = %d\n", tokens, destructors);
      return 1;
    }
  return !exit_status;
}
