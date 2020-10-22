%skeleton "lalr1.cc" %locations
%define api.location.type quux
%define api.namespace     quux
%define api.prefix        quux
%define api.token.prefix  quux
%token TOK // Otherwise api.token.prefix is unused.
%%
start: TOK;
