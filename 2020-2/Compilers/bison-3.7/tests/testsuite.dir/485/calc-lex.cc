/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>

#include "calc.hh"

#include <ctype.h>

int yylex (yy::parser::semantic_type *lvalp);


static int
get_char (yy::parser::semantic_type *lvalp)
{
  int res = getc (input);
  (void) lvalp;;

  return res;
}

static void
unget_char (yy::parser::semantic_type *lvalp,  int c)
{
  (void) lvalp;;

  ungetc (c, input);
}

static int
read_integer (yy::parser::semantic_type *lvalp)
{
  int c = get_char (lvalp);
  int res = 0;

  (void) lvalp;;
  while (isdigit (c))
    {
      res = 10 * res + (c - '0');
      c = get_char (lvalp);
    }

  unget_char (lvalp,  c);

  return res;
}


/*---------------------------------------------------------------.
| Lexical analyzer returns an integer on the stack and the token |
| NUM, or the ASCII character read if not a number.  Skips all   |
| blanks and tabs, returns 0 for EOF.                            |
`---------------------------------------------------------------*/

int yylex (yy::parser::semantic_type *lvalp)
{
  int c;
  /* Skip white spaces.  */
  do
    {

    }
  while ((c = get_char (lvalp)) == ' ' || c == '\t');

  /* Process numbers.   */
  if (isdigit (c))
    {
      unget_char (lvalp,  c);
      (*lvalp).ival = read_integer (lvalp);
      return yy::parser::token::NUM;
    }

  /* Return end-of-file.  */
  if (c == EOF)
    return yy::parser::token::CALC_EOF;

  /* An explicit error raised by the scanner. */
  if (c == '#')
    {
      fputs ("syntax error: invalid character: '#'\n", stderr);
      return yy::parser::token::YYerror;
    }

  /* Return single chars. */
  return c;
}
