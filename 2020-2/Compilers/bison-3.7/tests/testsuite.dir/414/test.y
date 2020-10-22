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

%skeleton "glr.cc"
           %define api.value.type {struct foo} %defines
%code requires { struct foo { float fval; int ival; }; }

%%

start: '1' '2'
             { printf ("%d %2.1f\n", $1.ival + $2.ival, $1.fval + $2.fval); };

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
  static char const input[] = "12";
  static int toknum = 0;
  int res;
  (void) lvalp;
  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  if (res)
             {
               (*lvalp).ival = (res - '0') * 10;
               (*lvalp).fval = YY_CAST (float, res - '0') / 10.f;
             };

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
