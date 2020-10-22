%nonassoc 'a' 'b' 'c'
%%
start:
    'a'
  | empty_a 'a'
  | 'b'
  | empty_b 'b'
  | 'c'
  | empty_c1 'c'
  | empty_c2 'c'
  | empty_c3 'c'
  ;
empty_a: %prec 'a' ;
empty_b: %prec 'b' ;
empty_c1: %prec 'c' ;
empty_c2: %prec 'c' ;
empty_c3: %prec 'c' ;
