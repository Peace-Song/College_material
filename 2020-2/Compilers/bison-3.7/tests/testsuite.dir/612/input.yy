%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%skeleton "lalr1.cc"
%defines

%code
{
  #include <cstdlib>
  int yylex (yy::parser::semantic_type *);
}

%define parse.error verbose
%define parse.trace
%%

start: with-recovery | '!' without-recovery;

with-recovery:
  %empty
| with-recovery item
| with-recovery error   { std::cerr << "caught error\n"; }
;

without-recovery:
  %empty
| without-recovery item
;

item:
  'a'
| 's'
  {
    throw syntax_error ("invalid expression");
  }

%%

void
yy::parser::error (const std::string &m)
{
  std::cerr << "error: " << m << '\n';
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
