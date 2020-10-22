%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%union
{
  int val;
};
%token <val> MY_TOKEN "MY TOKEN"
%type <val> exp
%%
exp: "MY TOKEN";
%%
