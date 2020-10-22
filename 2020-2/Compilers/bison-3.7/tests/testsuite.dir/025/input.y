%destructor { destroy ($$); } <field1>
%type <field1> start end

%%

start: end end { $1; } ;
end: { }  ;
