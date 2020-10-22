%token A D E
%%
s: A a d | A a a d E;
a: b;
b: c
c: %empty
d: D;
