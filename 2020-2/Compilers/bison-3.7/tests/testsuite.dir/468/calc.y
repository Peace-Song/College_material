%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

/* Infix notation calculator--calc */
%glr-parser %locations %define api.location.type {Span}

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

#include <stdio.h>
void location_print (FILE *o, Span s);
#define LOCATION_PRINT location_print



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

#if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
static int location_print (FILE *yyo, YYLTYPE const * const yylocp);
# ifndef LOCATION_PRINT
#  define LOCATION_PRINT(File, Loc) location_print (File, &(Loc))
# endif
#endif

static void yyerror (const char *msg);
  int yylex (void);


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


void
location_print (FILE *o, Span s)
{
  fprintf (o, "%d.%d", s.first.l, s.first.c);
  if (s.first.l != s.last.l)
    fprintf (o, "-%d.%d", s.last.l, s.last.c - 1);
  else if (s.first.c != s.last.c - 1)
    fprintf (o, "-%d", s.last.c - 1);
}


# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
/* Print *YYLOCP on YYO. */
__attribute__((__unused__))
static int
location_print (FILE *yyo, YYLTYPE const * const yylocp)
{
  int res = 0;
  int end_col = 0 != yylocp->last_column ? yylocp->last_column - 1 : 0;
  if (0 <= yylocp->first_line)
    {
      res += fprintf (yyo, "%d", yylocp->first_line);
      if (0 <= yylocp->first_column)
        res += fprintf (yyo, ".%d", yylocp->first_column);
    }
  if (0 <= yylocp->last_line)
    {
      if (yylocp->first_line < yylocp->last_line)
        {
          res += fprintf (yyo, "-%d", yylocp->last_line);
          if (0 <= end_col)
            res += fprintf (yyo, ".%d", end_col);
        }
      else if (0 <= end_col && yylocp->first_column < end_col)
        res += fprintf (yyo, "-%d", end_col);
    }
  return res;
}
#endif




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  LOCATION_PRINT (stderr, (yylloc));
  fprintf (stderr, ": ");
  fprintf (stderr, "%s\n", msg);
}
#include <ctype.h>

int yylex (void);


static YYLTYPE last_yylloc;

static int
get_char (void)
{
  int res = getc (input);
  ;

  last_yylloc = (yylloc);
  if (res == '\n')
    {
      (yylloc).last.l++;
      (yylloc).last.c = 1;
    }
  else
    (yylloc).last.c++;

  return res;
}

static void
unget_char ( int c)
{
  ;

  /* Wrong when C == '\n'. */
  (yylloc) = last_yylloc;

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

      (yylloc).first.c = (yylloc).last.c;
      (yylloc).first.l   = (yylloc).last.l;

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
      fprintf (stderr, "%d.%d: ",
               (yylloc).first.l, (yylloc).first.c);
      fputs ("syntax error: invalid character: '#'\n", stderr);
      return YYerror;
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


  status = yyparse ();
  if (fclose (input))
    perror ("fclose");
  return status;
}
