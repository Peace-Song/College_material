%union foo {};
%union {};
%union foo {};
%define api.value.union.name foo
%%
exp: %empty;
