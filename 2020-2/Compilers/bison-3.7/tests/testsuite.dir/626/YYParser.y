
%language "Java"
%locations
%debug
%define parse.error verbose
%token-table
%token END "end"




%%
start: END {};
%%
class Position {}
