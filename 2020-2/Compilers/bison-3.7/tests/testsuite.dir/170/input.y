%code {
  void yyerror (const char *msg);
  int yylex (void);
}
%union { void* ptr; }
%type <ptr> used1
%type <ptr> used2

%%
start
 : used1
 ;

used1
 : used2 { $$ = $1; }
 ;

unused
 : used2
 ;

used2
 : { $$ = YY_NULLPTR; }
 ;
