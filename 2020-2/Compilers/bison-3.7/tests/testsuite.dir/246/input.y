%left 'a'
%right 'b'
%right 'c'
%right 'd'
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
empty_a:  %empty %prec 'a' ;
empty_b:  %empty %prec 'b' ;
empty_c1: %empty %prec 'c' ;
empty_c2: %empty %prec 'c' ;
empty_c3: %empty %prec 'd' ;
