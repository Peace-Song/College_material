%expect 4
%%
exp:
  "number"
| exp "+" exp  %expect 2
| exp "*" exp  %expect 2
