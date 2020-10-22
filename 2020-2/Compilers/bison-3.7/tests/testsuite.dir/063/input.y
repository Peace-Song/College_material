%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%default-prec
%define parse.error verbose
%expect-rr 42
%file-prefix "foo"
%file-prefix
"bar"
%no-default-prec
%no-lines
%output "foo"
%token-table
%% exp : '0'
