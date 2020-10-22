%token EQ "=" PL "+" ST "*"  LP "("
%nonassoc "="
%left "+"
%left "*"
%precedence "("
%%
stmt:
  exp
| "var" "=" exp
;

exp:
  exp "+" exp
| exp "*" "num"
| "(" exp ")"
| "num"
;
