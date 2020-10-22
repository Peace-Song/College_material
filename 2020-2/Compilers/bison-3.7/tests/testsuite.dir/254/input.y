%token A B
%%
s: t | s t;
t: x | y;
x: A;
y: A A B;
