%code {
  void yyerror (const char *msg);
  int yylex (void);
}
%verbose
%output "input.c"
%token useful
%%
exp: useful;
useless1: '1';
useless2: '2';
useless3: '3';
useless4: '4';
useless5: '5';
useless6: '6';
useless7: '7';
useless8: '8';
useless9: '9';
