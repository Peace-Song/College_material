%token NUM OP
%expect 1
%%
exp: exp OP exp | NUM;
