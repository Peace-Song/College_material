%code top {
#error "2"
}
%code {
  void yyerror (const char *msg);
  int yylex (void);
}
%%
exp: '0';
%%
