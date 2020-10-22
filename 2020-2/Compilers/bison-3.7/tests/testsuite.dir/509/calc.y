%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

/* Infix notation calculator--calc */
%language "C++" %glr-parser %locations %define api.location.type {Span}

%code requires
{

  typedef struct
  {
    int l;
    int c;
  } Point;

  typedef struct
  {
    Point first;
    Point last;
  } Span;

# define YYLLOC_DEFAULT(Current, Rhs, N)                                \
  do                                                                    \
    if (N)                                                              \
      {                                                                 \
        (Current).first = YYRHSLOC (Rhs, 1).first;                      \
        (Current).last  = YYRHSLOC (Rhs, N).last;                       \
      }                                                                 \
    else                                                                \
      {                                                                 \
        (Current).first = (Current).last = YYRHSLOC (Rhs, 0).last;      \
      }                                                                 \
  while (0)




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


  int yylex (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp);


}



%initial-action
{
  @$.first.l = @$.first.c = 1;
  @$.last = @$.first;
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
        yyparser.error (@$, buf);
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


#include <iostream>
namespace
{
  std::ostream&
  operator<< (std::ostream& o, const Span& s)
  {
    o << s.first.l << '.' << s.first.c;
    if (s.first.l != s.last.l)
      o << '-' << s.last.l << '.' << s.last.c - 1;
    else if (s.first.c != s.last.c - 1)
      o << '-' << s.last.c - 1;
    return o;
  }
}

/* A C++ error reporting function.  */
void
yy::parser::error (const location_type& l, const std::string& m)
{
  std::cerr << l << ": " << m << '\n';
}
#include <ctype.h>

int yylex (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp);


static yy::parser::location_type last_yylloc;

static int
get_char (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp)
{
  int res = getc (input);
  (void) lvalp;(void) llocp;;

  last_yylloc = (*llocp);
  if (res == '\n')
    {
      (*llocp).last.l++;
      (*llocp).last.c = 1;
    }
  else
    (*llocp).last.c++;

  return res;
}

static void
unget_char (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp,  int c)
{
  (void) lvalp;(void) llocp;;

  /* Wrong when C == '\n'. */
  (*llocp) = last_yylloc;

  ungetc (c, input);
}

static int
read_integer (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp)
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

int yylex (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp)
{
  int c;
  /* Skip white spaces.  */
  do
    {

      (*llocp).first.c = (*llocp).last.c;
      (*llocp).first.l   = (*llocp).last.l;

    }
  while ((c = get_char (lvalp, llocp)) == ' ' || c == '\t');

  /* Process numbers.   */
  if (isdigit (c))
    {
      unget_char (lvalp, llocp,  c);
      (*lvalp).ival = read_integer (lvalp, llocp);
      return yy::parser::token::NUM;
    }

  /* Return end-of-file.  */
  if (c == EOF)
    return yy::parser::token::CALC_EOF;

  /* An explicit error raised by the scanner. */
  if (c == '#')
    {
      fprintf (stderr, "%d.%d: ",
               (*llocp).first.l, (*llocp).first.c);
      fputs ("syntax error: invalid character: '#'\n", stderr);
      return yy::parser::token::YYerror;
    }

  /* Return single chars. */
  return c;
}

#include <assert.h>
#include <unistd.h>


namespace
{
  /* A C++ yyparse that simulates the C signature.  */
  int
  yyparse ()
  {
    yy::parser parser;
  #if YYDEBUG
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


  status = yyparse ();
  if (fclose (input))
    perror ("fclose");
  return status;
}
