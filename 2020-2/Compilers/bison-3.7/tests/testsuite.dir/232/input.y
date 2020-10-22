%token NUM OP
%expect 2
%%
exp: exp OP exp | NUM;
