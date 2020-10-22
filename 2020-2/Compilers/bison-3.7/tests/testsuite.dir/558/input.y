%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%{
void yyerror (const char *msg);
int yylex (void);
#define YYSTYPE int *
%}

%define parse.error verbose

%%

program: 'x';
