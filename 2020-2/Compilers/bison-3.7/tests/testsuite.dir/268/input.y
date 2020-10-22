%code {
  void yyerror (const char *msg);
  int yylex (void);
}
%{
  /* Preprologue.  */
%}
%union
{
  int ival;
}
%{
#error "13"
%}
%%
exp: '0';
%%
