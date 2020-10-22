%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%default_prec
%error_verbose
%expect_rr 0
%file-prefix = "foo"
%file-prefix
 =
"bar"
	%fixed-output_files
        %fixed_output-files
%fixed-output-files
%name-prefix= "foo"
%no-default_prec
%no_default-prec
%no_lines
%output = "output.c"
%pure_parser
%token_table
%error-verbose
%glr-parser
%name-prefix "bar"
%%
exp : '0'
