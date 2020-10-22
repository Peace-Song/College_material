%token A B C D
%%
s: a A | B a C | b C | B b A;
a: D;
b: D;
