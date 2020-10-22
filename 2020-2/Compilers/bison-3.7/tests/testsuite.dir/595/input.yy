%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%skeleton "lalr1.cc"
%define api.value.automove
%token <int> NUMBER "number"
%type <int> exp
%%
exp:
  "number"          { $$ = $1; $$; }
| "twice" exp       { $$ = $2 + $2; }
| "thrice" exp[val] { $$ = $2 + $val + $2; }
