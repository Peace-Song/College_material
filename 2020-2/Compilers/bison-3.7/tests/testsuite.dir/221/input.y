%token NUM OP
%%
exp: exp OP exp | NUM;
