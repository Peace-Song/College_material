/* A useless token. */
%token useless_token
/* A useful one. */
%token useful
%verbose
%output "not-reduced.c"

%%

exp: useful            { /* A useful action. */ }
   | non_productive    { /* A non productive action. */ }
   ;

not_reachable: useful  { /* A not reachable action. */ }
             ;

non_productive: non_productive useless_token
                       { /* Another non productive action. */ }
              ;
%%
