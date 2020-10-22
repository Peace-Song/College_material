%printer {} foo baz
%destructor {} bar
%type <foo> qux
%%
exp: bar;
