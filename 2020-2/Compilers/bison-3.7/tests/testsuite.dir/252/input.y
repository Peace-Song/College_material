%token A B X Y
%%
s: ax by | A xby;
ax: A x;
x: %empty | X x;
by: B y;
y: %empty | Y y;
xby: B | X xby Y;
