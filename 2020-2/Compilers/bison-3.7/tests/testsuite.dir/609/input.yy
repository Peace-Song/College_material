%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%language "C++"
%define api.namespace {::foo}
%union { int i; }
%locations

%code {
  int yylex (::foo::parser::semantic_type *lval, const ::foo::parser::location_type*) {
    lval->i = 3;
    return 0;
  }
}

%%

start: ;

%%

void
::foo::parser::error (const ::foo::parser::location_type &loc,
                     const std::string &msg)
{
  std::cerr << "At " << loc << ": " << msg << '\n';
}

#include <cstdlib> // getenv.
#include <cstring> // strcmp.
int
main (int argc, char const* argv[])
{
  ::foo::parser p;
  (void) argc;
  (void) argv;
  return p.parse ();
}
