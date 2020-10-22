%token A B C
%%
s: a x | y c;
a: A;
c: C;
x: B | B C;
y: A | A B;
