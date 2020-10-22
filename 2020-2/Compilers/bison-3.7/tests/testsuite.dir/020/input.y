%destructor { destroy ($$); } <field1> <field2>
%printer { print ($$); } <field1> <field2>

%destructor { destroy ($$); } <field1> <field1>
%printer { print ($$); } <field2> <field2>

%%

start: %empty;

%destructor { destroy ($$); } <field2> <field1>;
%printer { print ($$); } <field2> <field1>;
