%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%token IDENT
%token NUMBER
%token ASSIGNOP
%token IF
%token IF1
%token THEN
%token ELSE
%token FI
%token WHILE
%token DO
%token OD
%start program
%%
if_stmt1: IF expr[cond] THEN stmt[then] ELSE stmt.list[else] FI
          { $if_stmt1 = new IfStmt($cond1, $then.f1, $else); };
if_stmt2: IF expr[cond] THEN stmt[then] FI
          { $if_stmt2 = new IfStmt($cond, $stmt.field, 0); };
if_stmt3: IF expr[cond] THEN stmt.list FI
          { $if_stmt3 = new IfStmt($cond, $stmt.list, 0); };
if_stmt4: IF expr[cond] THEN stmt[xyz] ELSE stmt[xyz] FI
          { $if_stmt4 = new IfStmt($cond, $xyz, $cond); };
if_stmt5: IF expr[cond] THEN stmt.list[then] ELSE stmt.list[else] FI
          { $if_stmt5 = new IfStmt($cond, $stmt.list, $else); };
if_stmt6: IF expr[cond] THEN stmt.list[then] ELSE stmt.list[else] FI
          { $if_stmt6 = new IfStmt($cond, $stmt.list.field, $else); };
if_stmt7: IF expr[cond] THEN stmt.list[then] ELSE stmt.list[else] FI
          { $if_stmt7 = new IfStmt($cond, $[stmt.list].field, $else); };
if_stmt8: IF expr[cond] THEN stmt.list[then.1] ELSE stmt.list[else] FI
          { $if_stmt8 = new IfStmt($cond, $then.1, $else); };
if_stmt9: IF expr[cond] THEN stmt.list[then.1] ELSE stmt.list[else] FI
          { $if_stmt9 = new IfStmt($cond, $then.1.field, $else); };
if_stmt10: IF expr[cond] THEN stmt[stmt.x] FI
          { $if_stmt10 = new IfStmt($cond, $stmt.x, 0); };
if-stmt-a: IF expr[cond] THEN stmt.list[then] ELSE stmt.list[else] FI
          { $if-stmt-a = new IfStmt($cond, $then, $else); };
if-stmt-b: IF expr[cond] THEN if-stmt-a[then-a] ELSE stmt.list[else] FI
          { $[if-stmt-b] = new IfStmt($cond, $then-a.f, $else); };
program: stmt.list;
stmt.list:  stmt ';' stmt.list { $3->insert($stmt); $$ = $3; }
        |   stmt ';' { SL = new StmtList();  SL->insert($1); $$ = SL; }
        ;
stmt:  assign_stmt { $$ = $1; }
    |  if_stmt { $$ = $1; }
    |  if_stmt1 { $$ = $1; }
    |  while_stmt { $$ = $1; }
    ;
assign_stmt: IDENT ASSIGNOP expr
       { $$ = new AssignStmt(string($1),$3); };
if_stmt: IF expr[cond] THEN stmt.list FI
       { $if_stmt = new IfStmt($cond, $[stmt.list], 0); };
while_stmt[res]: WHILE expr DO stmt.list OD
       { $res = new WhileStmt($[expr], $[stmt.list]); };
expr: expr '+' term   { $$ = new Plus($1,$3); }
    | expr '-' term   { $$ = new Minus($1,$3); }
    | term            { $$ = $1; }
    ;
term: term '*' factor   { $$ = new Times($1,$3); }
    | factor            { $$ = $1; }
    ;
factor:     '(' expr ')'  { $$ = $2; }
    |       NUMBER { $$ = new Number($1); }
    |       IDENT { $$ = new Ident(string($1)); }
    ;
