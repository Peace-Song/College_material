%token 'a' A1 1 "A1" A2 A3 "A3" A4 4
      <type_b> 'b' B5 5 "B5" B6 B7 "B8" B9 9
      <type_c> 'c' C10 10 "C10" C11 C12 "C12" C13 13

%left 'd' D20 20 "D20" D21 D22 "D22" D23 23
      <type_e> 'e' E25 25 "E25" E26 E27 "E28" E29 29
      <type_f> 'f' F30 30 "F30" F31 F32 "F32" F33 33

%type 'g' G40 "D40" G21 G22 G23
      <type_h> 'h' H25 "H25" H26 H27 "H28" H29
      <type_i> 'i' I30 "I30" I31 I32 "I32" I33

%nterm j60 j61 j62 j63
      <type_k> k75 k76 k77 k79
      <type_l> l80 l81 l82 l83
%%
exp:;
