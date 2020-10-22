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
           %define api.value.type {struct bar} %defines
%code requires
           {
             struct u
             {
               int ival;
             };
             struct bar
             {
               struct u *up;
             };
           }
           %token <up->ival> '1' '2'
           %printer { yyo << $$; } <up->ival>


%%

start: '1' '2'
           {
             printf ("%d %d\n", $1, $<up->ival>2);
             free ($<up>1);
             free ($<up>2);
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
               (*lvalp).up = YY_CAST (struct u *, malloc (sizeof *(*lvalp).up));
               assert ((*lvalp).up);
               (*lvalp).up->ival = res - '0';
             }
          ;

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
