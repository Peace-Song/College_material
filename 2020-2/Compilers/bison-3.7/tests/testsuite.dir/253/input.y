%token A B C D E
%%
g: s | x;
s: A x E | A x D E;
x: b cd | bc;
b: B;
cd: C D;
bc: B C;
