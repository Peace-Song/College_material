%token N A B C D
%%
s: n | n C;
n: N n D | N n C | N a B | N b;
a: A;
b: A B C | A B D;
