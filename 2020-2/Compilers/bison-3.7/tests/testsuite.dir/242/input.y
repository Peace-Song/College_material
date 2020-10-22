%left '+'
%left '*'

%%

%no-default-prec;

e:   e '+' e
   | e '*' e
   | '0'
   ;
