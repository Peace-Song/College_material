%require "3.2"
%skeleton "lalr1.cc"
%locations
%defines
%debug
%%
exp: %empty;
%%
/* A C++ error reporting function.  */
void
yy::parser::error (const location_type& l, const std::string& m)
{
  std::cerr << l << ": " << m << '\n';
}
