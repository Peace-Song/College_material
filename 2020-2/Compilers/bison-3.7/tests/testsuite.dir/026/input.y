/* 'Bison -v' used to dump core when two tokens are defined with the same
   string, as LE and GE below. */

%token NUM
%token LE "<="
%token GE "<="

%%
exp: '(' exp ')' | NUM ;
%%
