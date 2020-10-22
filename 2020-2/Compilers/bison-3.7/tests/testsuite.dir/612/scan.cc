/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>

#include <cstdio>  // getchar
#include "input.hh"

// 'a': valid item, 's': syntax error, 'l': lexical error.
int
yylex (yy::parser::semantic_type *lval)
{
  switch (int res = getchar ())
  {
    // Don't choke on echo's \n.
    case '\n':
      return yylex (lval);
    case 'l':
      throw yy::parser::syntax_error ("invalid character");
    default:
      return res;
  }
}
