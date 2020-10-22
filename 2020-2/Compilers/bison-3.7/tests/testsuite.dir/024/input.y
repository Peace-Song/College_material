%destructor { destroy ($$); } <>
%type <tag> tagged

%%

start: end end tagged tagged { $<tag>1; $3; } ;
end: { } ;
tagged: { } ;
