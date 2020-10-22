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

static yy::parser::symbol_type yylex ();
}

%skeleton "lalr1.cc"
             %define api.value.type variant
             %define api.token.constructor %defines
%token <std::pair<int, int>> '1' '2';

%%

start: '1' '2'
              {
                std::cout << $1.first << ':' << $1.second << ", "
                          << $2.first << ':' << $2.second << '\n';
              };

%%
/* A C++ error reporting function.  */
void
yy::parser::error (const std::string& m)
{
  std::cerr << m << '\n';
}
#include <assert.h>
static
yy::parser::symbol_type yylex ()
{
  static char const input[] = "12";
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  typedef yy::parser::symbol_type symbol;
             if (res)
               return symbol (res, std::make_pair (res - '0', res - '0' + 1));
             else
               return symbol (res);
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
