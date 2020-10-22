%union break
{
  char dummy;
}
%code {
  void yyerror (const char *msg);
  int yylex (void);
%}
%%
exp: '0';
%%
