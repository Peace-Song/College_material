
%language "Java"
%locations
%debug
%define parse.error verbose
%token-table
%token END "end"

%define extends {Thread}
%code init { super("Test Thread"); if (true) throw new InterruptedException(); }
%define init_throws {InterruptedException}
%lex-param {int lex_param}
%%
start: END {};
%%
class Position {}
