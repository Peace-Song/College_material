%token A B C
%%
s: ac | a bc;
ac: A ac C | b;
b: B | B b;
a: A | A a;
bc: B bc C | B C;
