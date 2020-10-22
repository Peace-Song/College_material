%%
start:
    'a'
  | empty_a 'a'
  | 'b'
  | empty_b 'b'
  | 'c'
  | empty_c 'c'
  ;
empty_a: %prec 'a';
empty_b: %prec 'b';
empty_c: %prec 'c';
