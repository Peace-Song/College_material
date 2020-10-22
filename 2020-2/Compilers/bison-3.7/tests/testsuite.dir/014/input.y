%union { int bar; }
%token foo
%type <bar> exp
%%
exp: foo { $$; } foo { $2; } foo
   | foo
   | %empty
   ;
