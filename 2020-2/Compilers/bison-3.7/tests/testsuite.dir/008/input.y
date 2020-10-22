%token TOKEN1
%nterm nterm1
%type <ival> TOKEN1 TOKEN2 "TOKEN3" nterm1 nterm2 nterm3 '+'
%token TOKEN2
%nterm nterm2
%%
expr: nterm1 nterm2 nterm3
nterm1: TOKEN1
nterm2: TOKEN2
nterm3: "TOKEN3"
