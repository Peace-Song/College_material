%token FOO
%nterm FOO BAR
%token BAR
%nterm error // The token error cannot be redefined as an nterm.
%%
FOO: BAR
BAR:
