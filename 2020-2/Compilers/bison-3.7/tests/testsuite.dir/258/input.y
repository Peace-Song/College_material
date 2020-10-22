%token H J K X
%%
s: a J;
a: H i;
i: X | i J K;
