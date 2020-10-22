%%
expr: expr "+" term | term
term: term "*" fact | fact
useless: "useless"
fact: "num"
