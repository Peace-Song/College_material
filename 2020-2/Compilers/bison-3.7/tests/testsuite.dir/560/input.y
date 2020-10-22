%{
void yyerror (const char *msg);
int yylex (void);
%}

%union
{
  int val;
};
%{
#ifndef MY_TOKEN
# error "MY_TOKEN not defined."
#endif
%}
%token MY_TOKEN
%%
exp: MY_TOKEN;
%%
