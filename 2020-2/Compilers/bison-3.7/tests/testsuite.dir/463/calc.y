%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

/* Infix notation calculator--calc */
%define parse.error custom %locations %define api.prefix {calc} %parse-param {semantic_value *result}{int *count}{int *nerrs} %define api.push-pull both %define api.pure full

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

#if defined CALCLTYPE_IS_TRIVIAL && CALCLTYPE_IS_TRIVIAL
static int location_print (FILE *yyo, CALCLTYPE const * const yylocp);
# ifndef LOCATION_PRINT
#  define LOCATION_PRINT(File, Loc) location_print (File, &(Loc))
# endif
#endif

static void calcerror (CALCLTYPE const * const llocp, semantic_value *result, int *count, int *nerrs, const char *msg);
  int calclex (CALCSTYPE *lvalp, CALCLTYPE *llocp);


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
        yyerror (&@$, result, count, nerrs, buf);
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



# if defined CALCLTYPE_IS_TRIVIAL && CALCLTYPE_IS_TRIVIAL
/* Print *YYLOCP on YYO. */
__attribute__((__unused__))
static int
location_print (FILE *yyo, CALCLTYPE const * const yylocp)
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



int
yyreport_syntax_error (const yypcontext_t *ctx, semantic_value *result, int *count, int *nerrs)
{
  int res = 0;
  YYUSE (result);
  YYUSE (count);
  YYUSE (nerrs);
  ++global_nerrs;
  ++*nerrs;
  LOCATION_PRINT (stderr, *yypcontext_location (ctx));
  fprintf (stderr, ": ");
  fprintf (stderr, "syntax error");
  {
    yysymbol_kind_t la = yypcontext_token (ctx);
    if (la != YYSYMBOL_YYEMPTY)
      fprintf (stderr, " on token [%s]", yysymbol_name (la));
  }
  {
    enum { TOKENMAX = 10 };
    yysymbol_kind_t expected[TOKENMAX];
    int n = yypcontext_expected_tokens (ctx, expected, TOKENMAX);
    /* Forward errors to yyparse.  */
    if (n <= 0)
      res = n;
    else
      {
        fprintf (stderr, " (expected:");
        for (int i = 0; i < n; ++i)
          fprintf (stderr, " [%s]", yysymbol_name (expected[i]));
        fprintf (stderr, ")");
      }
  }
  fprintf (stderr, "\n");
  return res;
}


/* A C error reporting function.  */
static
void calcerror (CALCLTYPE const * const llocp, semantic_value *result, int *count, int *nerrs, const char *msg)
{
  YYUSE (result);
  YYUSE (count);
  YYUSE (nerrs);
  LOCATION_PRINT (stderr, (*llocp));
  fprintf (stderr, ": ");
  fprintf (stderr, "%s\n", msg);
  ++global_nerrs;
  ++*nerrs;
}
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
