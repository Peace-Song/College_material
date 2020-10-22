%skeleton "lalr1.cc"
%union foo { float fval; int ival; };
%%
exp: %empty;
