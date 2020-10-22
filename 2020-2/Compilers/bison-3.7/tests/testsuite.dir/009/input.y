%nterm expr "expression";
%nterm term 123;
%nterm fact 124 "factor";
%nterm '+' '*';
%nterm "number";
%token "tok1" 1;
%left "tok2" 2;
%type "tok3" 3;
%%
expr: expr '+' term | term;
term: term '*' fact | fact;
fact: "number";
