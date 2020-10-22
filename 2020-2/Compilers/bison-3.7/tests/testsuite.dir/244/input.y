%left '+'
%left '*'

%%

%default-prec;

e:   e '+' e
   | e '*' e
   | '0'
   ;
