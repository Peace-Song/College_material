%skeleton "glr.cc"
%union foo { float fval; int ival; };
%%
exp: %empty;
