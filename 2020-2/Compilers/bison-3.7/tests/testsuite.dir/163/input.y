%token END 0
%%
input:
  'a'
| '(' input ')'
| '(' error END
;
