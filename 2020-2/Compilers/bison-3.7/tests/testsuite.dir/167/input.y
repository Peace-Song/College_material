%verbose
%output "input.c"

%token useless1
%token useless2
%token useless3
%token useless4
%token useless5
%token useless6
%token useless7
%token useless8
%token useless9

%token useful
%%
exp: useful;
