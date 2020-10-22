%token A B U V W X Y Z
%precedence Z
%left X
%precedence Y
%left W
%right V
%nonassoc U
%%
a: b
 | a U b
 | f
;
b: c
 | b V c
;
c: d
 | c W d
;
d: A
 | d X d
 | d Y A
;
f: B
 | f Z B
;
