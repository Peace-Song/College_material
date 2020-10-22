
%language "Java"
%locations
%debug
%define parse.error verbose
%token-table
%token END "end"

%define api.value.type {java.awt.Color}
%type<java.awt.Color> start;
%define api.location.type {MyLoc}
%define api.position.type {MyPos}
%code { class MyPos {} }
%%
start: END {$$ = $<java.awt.Color>1;};
%%
class MyPos {}
