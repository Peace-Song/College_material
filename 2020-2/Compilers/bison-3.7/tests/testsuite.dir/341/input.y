%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%skeleton "lalr1.cc"
%debug
%code requires
{
  typedef struct sem_type
  {
    int ival;
    float fval;
  } sem_type;

# define YYSTYPE sem_type


# include <cstdio> // EOF.
# include <iostream>
  namespace
  {
    void
    report (std::ostream& yyo, int ival, float fval)
    {
      yyo << "ival: " << ival << ", fval: " <<  fval;
    }
  }

}

%code
{

  static int yylex (yy::parser::semantic_type *lvalp);
}

%token UNTYPED
%token <ival> INT
%type <fval> float
%printer { report (yyo, $$,       $<fval>$); } <ival>;
%printer { report (yyo, $<ival>$, $$      ); } <fval>;
%printer { report (yyo, $<ival>$, $<fval>$); } <>;

%initial-action
{
  $<ival>$ = 42;
  $<fval>$ = 4.2f;
}

%%
float: UNTYPED INT
{
  $$       = $<fval>1 + $<fval>2;
  $<ival>$ = $<ival>1 + $2;
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
  static int const input[] = {yy::parser::token::UNTYPED,
                                 yy::parser::token::INT,
                                  EOF};
  static int toknum = 0;
  int res;
  (void) lvalp;
  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  (*lvalp).ival = toknum * 10;
                  (*lvalp).fval = YY_CAST (float, toknum) / 10.0f;;

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
