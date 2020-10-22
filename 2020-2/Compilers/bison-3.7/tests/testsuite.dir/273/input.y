%printer {
#error "2"
} <ival>
%debug
%code {
  void yyerror (const char *msg);
  int yylex (void);
}
%union {
  int ival;
}
%type <ival> exp
%%
exp: '0' { $$ = 0; };
%%
