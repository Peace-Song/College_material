/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>

#include "calc.h"

#include <ctype.h>

int calclex (CALCSTYPE *lvalp, CALCLTYPE *llocp);


static CALCLTYPE last_yylloc;

static int
get_char (CALCSTYPE *lvalp, CALCLTYPE *llocp)
{
  int res = getc (input);
  (void) lvalp;(void) llocp;;

  last_yylloc = (*llocp);
  if (res == '\n')
    {
      (*llocp).last_line++;
      (*llocp).last_column = 1;
    }
  else
    (*llocp).last_column++;

  return res;
}

static void
unget_char (CALCSTYPE *lvalp, CALCLTYPE *llocp,  int c)
{
  (void) lvalp;(void) llocp;;

  /* Wrong when C == '\n'. */
  (*llocp) = last_yylloc;

  ungetc (c, input);
}

static int
read_integer (CALCSTYPE *lvalp, CALCLTYPE *llocp)
{
  int c = get_char (lvalp, llocp);
  int res = 0;

  (void) lvalp;(void) llocp;;
  while (isdigit (c))
    {
      res = 10 * res + (c - '0');
      c = get_char (lvalp, llocp);
    }

  unget_char (lvalp, llocp,  c);

  return res;
}


/*---------------------------------------------------------------.
| Lexical analyzer returns an integer on the stack and the token |
| NUM, or the ASCII character read if not a number.  Skips all   |
| blanks and tabs, returns 0 for EOF.                            |
`---------------------------------------------------------------*/

int calclex (CALCSTYPE *lvalp, CALCLTYPE *llocp)
{
  int c;
  /* Skip white spaces.  */
  do
    {

      (*llocp).first_column = (*llocp).last_column;
      (*llocp).first_line   = (*llocp).last_line;

    }
  while ((c = get_char (lvalp, llocp)) == ' ' || c == '\t');

  /* Process numbers.   */
  if (isdigit (c))
    {
      unget_char (lvalp, llocp,  c);
      (*lvalp).ival = read_integer (lvalp, llocp);
      return NUM;
    }

  /* Return end-of-file.  */
  if (c == EOF)
    return CALC_EOF;

  /* An explicit error raised by the scanner. */
  if (c == '#')
    {
      fprintf (stderr, "%d.%d: ",
               (*llocp).first_line, (*llocp).first_column);
      fputs ("syntax error: invalid character: '#'\n", stderr);
      return CALCerror;
    }

  /* Return single chars. */
  return c;
}
