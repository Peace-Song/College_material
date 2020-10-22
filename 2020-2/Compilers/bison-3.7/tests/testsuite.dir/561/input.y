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
void print_my_token (void);
%}

%union
{
  int val;
};
%{
#include <stdio.h>
void
print_my_token (void)
{
  enum yytokentype tok1 = MY_TOKEN;
  yytoken_kind_t   tok2 = MY_TOKEN;
  printf ("%d, %d\n", tok1, tok2);
}
%}
%token MY_TOKEN
%%
exp: MY_TOKEN;
%%
