%code {
  void yyerror (const char *msg);
  int yylex (void);
}
%%
exp:
{
#error "8"
};
