
%language "Java"
%locations
%debug
%define parse.error verbose
%token-table
%token END "end"
%define extends {Thread}
%%
start: END {};
%%
class Position {}
