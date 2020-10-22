%token foo "foo"
%type <bar> "foo"
%type <baz> foo
%%
exp: foo;
