/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>

#include "calc.h"

#include <ctype.h>

int yylex (void);


static int
get_char (void)
{
  int res = getc (input);
  ;

  return res;
}

static void
unget_char ( int c)
{
  ;

  ungetc (c, input);
}

static int
read_integer (void)
{
  int c = get_char ();
  int res = 0;

  ;
  while (isdigit (c))
    {
      res = 10 * res + (c - '0');
      c = get_char ();
    }

  unget_char ( c);

  return res;
}


/*---------------------------------------------------------------.
| Lexical analyzer returns an integer on the stack and the token |
| NUM, or the ASCII character read if not a number.  Skips all   |
| blanks and tabs, returns 0 for EOF.                            |
`---------------------------------------------------------------*/

int yylex (void)
{
  int c;
  /* Skip white spaces.  */
  do
    {

    }
  while ((c = get_char ()) == ' ' || c == '\t');

  /* Process numbers.   */
  if (isdigit (c))
    {
      unget_char ( c);
      (yylval).ival = read_integer ();
      return NUM;
    }

  /* Return end-of-file.  */
  if (c == EOF)
    return CALC_EOF;

  /* An explicit error raised by the scanner. */
  if (c == '#')
    {
      fputs ("syntax error: invalid character: '#'\n", stderr);
      return YYerror;
    }

  /* Return single chars. */
  return c;
}
