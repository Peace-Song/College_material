%token A D
%%
s: A a d | A a a d;
a: b;
b: c
c: %empty
d: D;
