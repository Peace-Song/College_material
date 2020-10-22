%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
%}

%token T_CONSTANT
%token T_PORT
%token T_SIGNAL

%define parse.assert
%glr-parser

%%


PortClause      : T_PORT InterfaceDeclaration T_PORT
                { printf("%d/%d - %d/%d - %d/%d\n",
                         @1.first_column, @1.last_column,
                         @2.first_column, @2.last_column,
                         @3.first_column, @3.last_column); }
        ;

InterfaceDeclaration    : OptConstantWord       %dprec 1
        | OptSignalWord %dprec 2
        ;

OptConstantWord : %empty
        | T_CONSTANT
        ;

OptSignalWord   : %empty
                { printf("empty: %d/%d\n", @$.first_column, @$.last_column); }
        | T_SIGNAL
        ;

%%





/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
static int lexIndex;

int yylex (void)
{
  lexIndex += 1;
  switch (lexIndex)
    {
    default:
      abort ();
    case 1:
      yylloc.first_column = 1;
      yylloc.last_column = 9;
      return T_PORT;
    case 2:
      yylloc.first_column = 13;
      yylloc.last_column = 17;
      return T_PORT;
    case 3:
      return 0;
    }
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
