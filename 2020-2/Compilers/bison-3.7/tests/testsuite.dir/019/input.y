%destructor { destroy ($$); } <> <>
%printer { print ($$); } <> <>

%destructor { destroy ($$); } <>
%printer { print ($$); } <>

%%

start: %empty;

%destructor { destroy ($$); } <>;
%printer { print ($$); } <>;
