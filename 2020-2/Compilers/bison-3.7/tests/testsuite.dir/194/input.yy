%token
  END  0  "end of file"
  ASSIGN  ":="
  INCR    "incr"
;

%token <std::string> IDENTIFIER "identifier"
%type <std::string> id
%token <int> NUMBER "number"
%type  <int> exp

%%
%start unit;
unit: assignments exp  { driver.result = $2; };

assignments:
  %empty                 {}
| assignments assignment {};

assignment:
  id ":=" exp { driver.variables[$id] = $exp; };

id:
  "identifier";

exp:
  "incr" exp <int>{ $$ = 1; } <int>{ $$ = 10; } exp   { $$ = $2 + $3 + $4 + $5; }
| "(" exp ")"   { std::swap ($$, $2); }
| "identifier"  { $$ = driver.variables[$1]; }
| "number"      { std::swap ($$, $1); };
