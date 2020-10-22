%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%type <TYPE> exp
%token <TYPE> TOK TOK2
%destructor     { $%; @%; } <*> exp TOK;
%initial-action { $%; @%; };
%printer        { $%; @%; } <*> exp TOK;
%{ $ @ %} // Should not warn.
%%
exp: TOK        { $%; @%; $$ = $1; }
   | 'a'        { $<->1; $$ = 1; }
   | 'b'        { $<foo->bar>$; }
%%
$ @ // Should not warn.
