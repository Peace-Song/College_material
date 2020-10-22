%%
exp: ifexp | opexp | imm;
ifexp: "if" exp "then" exp elseexp;
elseexp: "else" exp | ;
opexp: exp '+' exp;
imm: '0';
