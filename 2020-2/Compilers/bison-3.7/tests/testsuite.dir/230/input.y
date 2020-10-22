%token NUM OP
%expect 0
%%
exp: exp OP exp | NUM;
