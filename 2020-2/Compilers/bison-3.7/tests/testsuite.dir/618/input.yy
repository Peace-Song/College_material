%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%skeleton "glr.cc"

%union
{
  int ival;
}

%token <ival> ZERO;

%code
{
  int yylex (yy::parser::semantic_type *lvalp);
}

%%
exp: ZERO

%%

int yylex (yy::parser::semantic_type *lvalp)
{
  // Note: this argument is unused, but named on purpose.  There used to be a
  // bug with a macro that erroneously expanded this identifier to
  // yystackp->yyval.
  YYUSE (lvalp);
  return yy::parser::token::ZERO;
}

void yy::parser::error (std::string const&)
{}

int main ()
{}
