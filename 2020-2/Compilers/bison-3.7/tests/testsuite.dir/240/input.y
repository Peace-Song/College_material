%glr-parser
%expect-rr 3
%%
exp
: a '1'
| a '2'
| a '3'
| b '1'
| b '2'
| b '3'
a:
b: %expect-rr 2
