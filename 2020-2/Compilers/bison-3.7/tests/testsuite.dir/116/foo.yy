%skeleton "lalr1.cc" %defines %locations %define api.location.file "$at_dir/foo.loc.hh" %require "3.2"
%%
foo: '0' {};
