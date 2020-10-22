%token FOO "foo"
%type <val> "bar"
%%
expr: "foo" "bar" "baz"
