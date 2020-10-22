%token A
%%
a : b d | c d ;
b : ;
c : ;
d : a | c A | d;
