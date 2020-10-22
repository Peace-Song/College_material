%token <type1> tag1
%type <type2> tag2

%printer { } <type1> <type3>
%destructor { } <type2> <type4>

%%

exp: tag1 { $1; }
   | tag2 { $1; }

tag2: "a" { $$; }
