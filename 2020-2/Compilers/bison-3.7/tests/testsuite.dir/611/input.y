%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%skeleton "lalr1.cc"

%code {
  #include <string>
  int yylex (yy::parser::semantic_type *);
  #define USE(Args)
}

%define parse.error verbose

%nonassoc 'a' ;

%destructor {
  std::cerr << "Discarding 'a'.\n";
} 'a'

%%

start: error-reduce consistent-error 'a' { USE ($3); };

error-reduce:
  'a' 'a' consistent-error 'a' { USE (($1, $2, $4)); }
| 'a' error { std::cerr << "Reducing 'a'.\n"; USE ($1); }
;

consistent-error:
  'a'
| %empty %prec 'a'
;

// Provide another context in which all rules are useful so that this
// test case looks a little more realistic.
start: 'b' consistent-error ;

%%

int
yylex (yy::parser::semantic_type *)
{
  static char const *input = "aa";
  return *input++;
}

void
yy::parser::error (const std::string &m)
{
  std::cerr << m << '\n';
}

#include <cstdlib> // getenv.
#include <cstring> // strcmp.
int
main (int argc, char const* argv[])
{
  yy::parser p;
  (void) argc;
  (void) argv;
  return p.parse ();
}
