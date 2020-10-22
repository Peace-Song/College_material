%token A
%%
a : A b ;
b : A | b;
