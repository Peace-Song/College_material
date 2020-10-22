%nonassoc '<' '>'
%left '+' '-'
%right '^' '='
%%
exp:
   exp '<' exp
 | exp '>' exp
 | exp '+' exp
 | exp '-' exp
 | exp '^' exp
 | exp '=' exp
 | "exp"
 ;
