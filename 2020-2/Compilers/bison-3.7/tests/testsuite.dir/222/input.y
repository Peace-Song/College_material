%token NUM OP
%left OP
%%
exp: exp OP exp | NUM;
