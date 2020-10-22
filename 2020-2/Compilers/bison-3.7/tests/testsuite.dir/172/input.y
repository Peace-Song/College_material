%verbose
%output "input.c"
%token useful
%%
exp: useful | underivable;
underivable: indirection;
indirection: underivable;
