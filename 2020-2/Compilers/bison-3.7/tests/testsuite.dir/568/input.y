%token        undef_id_tok const_id_tok

%start CONST_DEC_PART

%%
CONST_DEC_PART:
         CONST_DEC_LIST
        ;

CONST_DEC_LIST:
          CONST_DEC
        | CONST_DEC_LIST CONST_DEC
        ;

CONST_DEC:
          { } undef_id_tok '=' const_id_tok ';'
        ;
%%
