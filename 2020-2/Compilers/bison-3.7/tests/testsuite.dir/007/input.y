%destructor {} <int>
%printer {} <int>
%type <int> exp a b
%%
exp: a b             { $$ = $1 + $2; };
a: <int>{ $$ = 42; } { $$ = $1; };
b: %empty            { $$ = 42; };
