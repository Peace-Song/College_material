%code {
  void yyerror (const char *msg);
  int yylex (void);
}
%verbose
%output "input.c"

%token useful
%%
exp: useful;
useless1:
useless2:
useless3:
