%code {
  void yyerror (const char *msg);
  int yylex (void);
}
%%
exp: '0';
%%
#error "8"
