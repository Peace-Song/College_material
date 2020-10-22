%{
void yyerror (const char *msg);
int yylex (void);
%}
%define api.value.type union
%type <int> '0' exp
%destructor { /* --BEGIN */
              destructor
              /* --END   */ } <*>
%printer { /* --BEGIN */
           printer
           /* --END   */ } <*>



%left '+'
%%
exp: exp '+' exp {  /* --BEGIN */
                    $$ = $1 + $3;
                    @$ = @1 + @3;
                    /* --END */ }
   | '0'
