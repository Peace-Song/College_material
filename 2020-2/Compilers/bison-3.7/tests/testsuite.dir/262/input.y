%token H J
%%
s: a | a J;
a: H i J J
i: %empty | i J;
