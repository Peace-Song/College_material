%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%token DECIMAL_1     11259375
         HEXADECIMAL_1 0xabcdef
         HEXADECIMAL_2 0xFEDCBA
         DECIMAL_2     16702650
%%
start: DECIMAL_1 HEXADECIMAL_2;
