
%language "Java"
%locations
%debug
%define parse.error verbose
%token-table
%token END "end"
%define abstract
%%
start: END {};
%%
class Position {}
