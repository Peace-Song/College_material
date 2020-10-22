%token <type1> token1
%token <type2> token2
%token <type3> token3
%token <type4> token4
%token <type5> token51 token52
%token <type6> token61 token62
%token <type7> token7

%printer {} token1
%destructor {} token2
%printer {} token51
%destructor {} token61

%printer {} token7

%printer {} <type1>
%destructor {} <type2>
%printer {} <type3>
%destructor {} <type4>

%printer {} <type5>
%destructor {} <type6>

%destructor {} <type7>

%%
exp: "a";
