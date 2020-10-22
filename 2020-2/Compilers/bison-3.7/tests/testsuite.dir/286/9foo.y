%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%glr-parser
%{
#include <9foo.h>
void yyerror (const char *msg);
int yylex (void);
%}
%%
dummy: %empty;
%%
#include <9foo.h>
