%left '+'
%left '*'

%%

%no-default-prec;

e:   e '+' e %prec '+'
   | e '*' e %prec '*'
   | '0'
   ;
