%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%skeleton "glr.c" %defines
%{
void yyerror (const char *msg);
int yylex (void);
%}
%union {
  int ival;
}
%%
exp: '0'
