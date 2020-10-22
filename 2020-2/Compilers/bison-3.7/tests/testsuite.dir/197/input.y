%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%token 'a' 'b' C D
%token E F 'g' 'h'
%right 'i' 'j' K L
%right M N 'o' 'p'
%%
exp: 'a'
   | 'b'
   | C
   | D
   | E
   | F
   | 'g'
   | 'h'
   | 'i'
   | 'j'
   | K
   | L
   | M
   | N
   | 'o'
   | 'p'
;
%%
