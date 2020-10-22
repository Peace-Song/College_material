%%
statement:  struct_stat;
struct_stat:  %empty | if else;
if: "if" "const" "then" statement;
else: "else" statement;
%%
