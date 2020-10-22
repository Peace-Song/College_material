%skeleton "lalr1.cc" %defines %locations %define api.location.file "foo.loc.hh" %require "3.2"
%%
foo: '0' {};
