%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}



%code {
  #include <assert.h>

  static int yylex (yy::parser::semantic_type *lvalp);
  #define USE(Var)
}

%defines



%language "c++"
                             %define lr.type ielr
                             %define parse.lac full

%define parse.error verbose

%%

%nonassoc 'a';

start: consistent-error-on-a-a 'a' ;

consistent-error-on-a-a:
    'a' default-reduction
  | 'a' default-reduction 'a'
  | 'a' shift
  ;

default-reduction: %empty ;
shift: 'b' ;

// Provide another context in which all rules are useful so that this
// test case looks a little more realistic.
start: 'b' consistent-error-on-a-a 'c' ;



%%
#include <assert.h>
static
int yylex (yy::parser::semantic_type *lvalp)
{
  static char const input[] = "a";
  static int toknum = 0;
  int res;
  (void) lvalp;
  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  *lvalp = 1;

  return res;
}
/* A C++ error reporting function.  */
void
yy::parser::error (const std::string& m)
{
  std::cerr << m << '\n';
}


/*-------.
| main.  |
`-------*/
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
