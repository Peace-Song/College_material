%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%locations
%debug
%skeleton "lalr1.cc"


%code
{
# include <stdio.h>
# include <stdlib.h> /* getenv */

static int yylex (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp);
}
%%
exp: { std::cerr << @$ << '\n'; }
%%
/* A C++ error reporting function.  */
void
yy::parser::error (const location_type& l, const std::string& m)
{
  std::cerr << l << ": " << m << '\n';
}

int yylex (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp)
{
  YYUSE(lvalp);
  YYUSE(llocp);
  return 'x';
}

int
main (void)
{
  yy::parser p;
  p.set_debug_level (!!getenv ("YYDEBUG"));
  return p.parse ();
}
