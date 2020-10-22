%precedence "then"
%precedence "else"
%%
stmt:
  "if" cond "then" stmt
| "if" cond "then" stmt "else" stmt
| "stmt"
;

cond:
  "exp"
;
