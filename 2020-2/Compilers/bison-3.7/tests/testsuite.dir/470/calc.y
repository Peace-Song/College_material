%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

/* Infix notation calculator--calc */
%glr-parser %define api.prefix {calc}

%code requires
{

  /* Exercise pre-prologue dependency to %union.  */
  typedef int semantic_value;
}


/* Exercise %union. */
%union
{
  semantic_value ival;
};
%printer { fprintf (yyo, "%d", $$); } <ival>;


%code provides
{
  #include <stdio.h>
  /* The input.  */
  extern FILE *input;
  extern semantic_value global_result;
  extern int global_count;
  extern int global_nerrs;
}

%code
{
  #include <assert.h>
  #include <string.h>
  #define USE(Var)

  FILE *input;
  static int power (int base, int exponent);

  #include <stdio.h>

static void calcerror (const char *msg);
  int calclex (void);


}




/* Bison Declarations */
%token CALC_EOF 0 "end of input"
%token <ival> NUM   "number"
%type  <ival> exp

%nonassoc '='   /* comparison          */
%left '-' '+'
%left '*' '/'
%precedence NEG /* negation--unary minus */
%right '^'      /* exponentiation        */

/* Grammar follows */
%%
input:
  line
| input line         {  }
;

line:
  '\n'
| exp '\n'           { USE ($1); }
;

exp:
  NUM
| exp '=' exp
  {
    if ($1 != $3)
      {
        char buf[1024];
        snprintf (buf, sizeof buf, "calc: error: %d != %d", $1, $3);
        {
          YYLTYPE old_yylloc = yylloc;
          yylloc = @$;
          yyerror (buf);
          yylloc = old_yylloc;
        }

      }
    $$ = $1;
  }
| exp '+' exp        { $$ = $1 + $3; }
| exp '-' exp        { $$ = $1 - $3; }
| exp '*' exp        { $$ = $1 * $3; }
| exp '/' exp        { $$ = $1 / $3; }
| '-' exp  %prec NEG { $$ = -$2; }
| exp '^' exp        { $$ = power ($1, $3); }
| '(' exp ')'        { $$ = $2; }
| '(' error ')'      { $$ = 1111; yyerrok; }
| '!'                { $$ = 0; YYERROR; }
| '-' error          { $$ = 0; YYERROR; }
;
%%

int
power (int base, int exponent)
{
  int res = 1;
  assert (0 <= exponent);
  for (/* Niente */; exponent; --exponent)
    res *= base;
  return res;
}






/* A C error reporting function.  */
static
void calcerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
#include <ctype.h>

int calclex (void);


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

int calclex (void)
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
      (calclval).ival = read_integer ();
      return NUM;
    }

  /* Return end-of-file.  */
  if (c == EOF)
    return CALC_EOF;

  /* An explicit error raised by the scanner. */
  if (c == '#')
    {
      fputs ("syntax error: invalid character: '#'\n", stderr);
      return CALCerror;
    }

  /* Return single chars. */
  return c;
}

#include <assert.h>
#include <unistd.h>



/* Value of the last computation.  */
semantic_value global_result = 0;
/* Total number of computations.  */
int global_count = 0;
/* Total number of errors.  */
int global_nerrs = 0;

/* A C main function.  */
int
main (int argc, const char **argv)
{
  int status;

  /* This used to be alarm (10), but that isn't enough time for a July
     1995 vintage DEC Alphastation 200 4/100 system, according to
     Nelson H. F. Beebe.  100 seconds was enough for regular users,
     but the Hydra build farm, which is heavily loaded needs more.  */

  alarm (200);

  if (argc == 2)
    input = fopen (argv[1], "r");
  else
    input = stdin;

  if (!input)
    {
      perror (argv[1]);
      return 3;
    }


  status = calcparse ();
  if (fclose (input))
    perror ("fclose");
  return status;
}
