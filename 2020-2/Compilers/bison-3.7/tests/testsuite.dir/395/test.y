%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%debug

%code
{
# include <stdio.h>
# include <stdlib.h>

static int yylex (yy::parser::semantic_type *lvalp);
}

%skeleton "lalr1.cc"
           %define api.value.type union
%token <int> ONE 101;
           %token <float> TWO 102 THREE 103;
           %printer { yyo << $$; } <int>
           %printer { yyo << $$; } <float>


%%

start: ONE TWO THREE { printf ("%d %2.1f %2.1f\n", $1, $2, $3); };

%%
/* A C++ error reporting function.  */
void
yy::parser::error (const std::string& m)
{
  std::cerr << m << '\n';
}
#include <assert.h>
static
int yylex (yy::parser::semantic_type *lvalp)
{
  static int const input[] = { 101, 102, 103, EOF };
  static int toknum = 0;
  int res;
  (void) lvalp;
  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  if (res == 101)
             (*lvalp).ONE = 10;
           else if (res == 102)
             (*lvalp).TWO = .2f;
           else if (res == 103)
             (*lvalp).THREE = 3.3f;

  return res;
}
#include <cstdlib> // getenv.
#include <cstring> // strcmp.
int
main (int argc, char const* argv[])
{
  yy::parser p;
  int debug = !!getenv ("YYDEBUG");
  for (int i = 1; i < argc; ++i)
    if (!strcmp (argv[i], "-p")
        || !strcmp (argv[i], "-d") || !strcmp (argv[i], "--debug"))
      debug |= 1;
    else if (!strcmp (argv[i], "-s") || !strcmp (argv[i], "--stat"))
      debug |= 2;
  p.set_debug_level (debug);
  return p.parse ();
}
