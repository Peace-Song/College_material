%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

/* Infix notation calculator--calc */
%language "C++" %define parse.error custom %locations %define api.prefix {calc} %parse-param {semantic_value *result}{int *count}{int *nerrs}

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
%printer { yyo << $$; } <ival>;


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


  int calclex (calc::parser::semantic_type *lvalp, calc::parser::location_type *llocp);


#define N_
    static
    const char *
    _ (const char *cp)
    {
      if (strcmp (cp, "end of input") == 0)
        return "end of file";
      else if (strcmp (cp, "number") == 0)
        return "nombre";
      else
        return cp;
    }

}




/* Bison Declarations */
%token CALC_EOF 0 _("end of input")
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
| input line         { ++*count; ++global_count; }
;

line:
  '\n'
| exp '\n'           { *result = global_result = $1; }
;

exp:
  NUM
| exp '=' exp
  {
    if ($1 != $3)
      {
        char buf[1024];
        snprintf (buf, sizeof buf, "calc: error: %d != %d", $1, $3);
        error (@$, buf);
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


/* A C++ error reporting function.  */
void
calc::parser::error (const location_type& l, const std::string& m)
{
  ++global_nerrs;
  ++*nerrs;
  std::cerr << l << ": " << m << '\n';
}
void
calc::parser::report_syntax_error (const context& ctx) const
{
  YYUSE (result);
  YYUSE (count);
  YYUSE (nerrs);
  ++global_nerrs;
  ++*nerrs;
  std::cerr << ctx.location () << ": ";
  std::cerr << "syntax error";
  {
    symbol_kind_type la = ctx.token ();
    if (la != symbol_kind::S_YYEMPTY)
      std::cerr << " on token [" << symbol_name (la) << ']';
  }
  {
    enum { TOKENMAX = 10 };
    symbol_kind_type expected[TOKENMAX];
    int n = ctx.expected_tokens (expected, TOKENMAX);
    if (0 < n)
      {
        std::cerr << " (expected:";
        for (int i = 0; i < n; ++i)
          std::cerr << " [" << symbol_name (expected[i]) << ']';
        std::cerr << ')';
      }
  }
  std::cerr << '\n';
}
#include <ctype.h>

int calclex (calc::parser::semantic_type *lvalp, calc::parser::location_type *llocp);


static calc::parser::location_type last_yylloc;

static int
get_char (calc::parser::semantic_type *lvalp, calc::parser::location_type *llocp)
{
  int res = getc (input);
  (void) lvalp;(void) llocp;;

  last_yylloc = (*llocp);
  if (res == '\n')
    {
      (*llocp).end.line++;
      (*llocp).end.column = 1;
    }
  else
    (*llocp).end.column++;

  return res;
}

static void
unget_char (calc::parser::semantic_type *lvalp, calc::parser::location_type *llocp,  int c)
{
  (void) lvalp;(void) llocp;;

  /* Wrong when C == '\n'. */
  (*llocp) = last_yylloc;

  ungetc (c, input);
}

static int
read_integer (calc::parser::semantic_type *lvalp, calc::parser::location_type *llocp)
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

int calclex (calc::parser::semantic_type *lvalp, calc::parser::location_type *llocp)
{
  int c;
  /* Skip white spaces.  */
  do
    {

      (*llocp).begin.column = (*llocp).end.column;
      (*llocp).begin.line   = (*llocp).end.line;

    }
  while ((c = get_char (lvalp, llocp)) == ' ' || c == '\t');

  /* Process numbers.   */
  if (isdigit (c))
    {
      unget_char (lvalp, llocp,  c);
      (*lvalp).ival = read_integer (lvalp, llocp);
      return calc::parser::token::NUM;
    }

  /* Return end-of-file.  */
  if (c == EOF)
    return calc::parser::token::CALC_EOF;

  /* An explicit error raised by the scanner. */
  if (c == '#')
    {
      fprintf (stderr, "%d.%d: ",
               (*llocp).begin.line, (*llocp).begin.column);
      fputs ("syntax error: invalid character: '#'\n", stderr);
      return calc::parser::token::CALCerror;
    }

  /* Return single chars. */
  return c;
}

#include <assert.h>
#include <unistd.h>


namespace
{
  /* A C++ calcparse that simulates the C signature.  */
  int
  calcparse (semantic_value *result, int *count, int *nerrs)
  {
    calc::parser parser (result, count, nerrs);
  #if CALCDEBUG
    parser.set_debug_level (1);
  #endif
    return parser.parse ();
  }
}


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
  semantic_value result = 0;
  int count = 0;
  int nerrs = 0;
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


  status = calcparse (&result, &count, &nerrs);
  if (fclose (input))
    perror ("fclose");
  assert (global_result == result); (void) result;
  assert (global_count  == count);  (void) count;
  assert (global_nerrs  == nerrs);  (void) nerrs;
  printf ("final: %d %d %d\n", global_result, global_count, global_nerrs);
  return status;
}
