%token A B X Y
%%
a: r t | s;
r: b;
b: B;
t: A xx | A x xy;
s: b A xx y;
x: X;
xx: X X;
xy: X Y;
y: Y;
