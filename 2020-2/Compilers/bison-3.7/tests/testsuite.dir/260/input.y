%left b
%right c
%%
S: B C | C B;
A : B  | C  | %empty;
B : A b A;
C : A c A;
