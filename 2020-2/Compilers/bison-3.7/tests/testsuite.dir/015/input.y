%token <integer> INT;
%type <integer> a b c d e f g h i j k l m n o;
%destructor { destroy ($$); } <integer>;
%%
start:
  'a' a { $2; } | 'b' b { $2; } | 'c' c { $2; } | 'd' d { $2; }
| 'e' e { $2; } | 'f' f { $2; } | 'g' g { $2; } | 'h' h { $2; }
| 'i' i { $2; } | 'j' j { $2; } | 'k' k { $2; } | 'l' l { $2; }
| 'm' m { $2; } | 'n' n { $2; } | 'o' o { $2; }
;

a: INT | INT { } INT { } INT { };
b: INT | %empty;
c: INT | INT { $1; } INT { $<integer>2; } INT { $<integer>4; };
d: INT | INT { } INT { $1; } INT { $<integer>2; };
e: INT | INT { } INT {  } INT { $1; };
f: INT | INT { } INT {  } INT { $$ = $1 + $3 + $5; };
g: INT | INT { $<integer>$; } INT { $<integer>$; } INT { };
h: INT | INT { $<integer>$; } INT { $<integer>$ = $<integer>2; } INT { };
i: INT | INT INT { } { $$ = $1 + $2; };
j: INT | INT INT { $<integer>$ = 1; } { $$ = $1 + $2; };
k: INT | INT INT { $<integer>$; } { $<integer>$ = $<integer>3; } { };
l: INT | INT { $<integer>$ = $<integer>1; } INT { $<integer>$ = $<integer>2 + $<integer>3; } INT { $<integer>$ = $<integer>4 + $<integer>5; };
m: INT | INT <integer>{ $$ = $1; } INT <integer>{ $$ = $2 + $3; } INT { $$ = $4 + $5; };
n: INT | INT <integer>{ } INT <integer>{ } INT { };
o: INT | INT <integer>{ } INT <integer>{ } INT { $$ = $1 + $2 + $3 + $4 + $5; };

