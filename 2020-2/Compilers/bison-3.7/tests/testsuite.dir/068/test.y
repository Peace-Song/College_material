%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%{
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
typedef int semantic_value;
FILE *input;
static semantic_value global_result = 0;
static int global_count = 0;
static int power (int base, int exponent);
#include <stdio.h>

static void yyerror (const char *msg);
static int yylex (void);
%}

%union
{
  semantic_value ival;
};

%token CALC_EOF 0 "end of input"
%token <ival> NUM "number"
%type  <ival> exp

%nonassoc '='   /* comparison          */
%left '-' '+'
%left '*' '/'
%precedence NEG /* negation--unary minus */
%right '^'      /* exponentiation        */

%%
input:
  line
| input line         {}
;

line:
  '\n'
| exp '\n'           {}
;

exp:
  NUM                { $$ = $NUM; }
| exp[l] '=' exp[r]
  {
    if ($l != $r)
      fprintf (stderr, "calc: error: %d != %d\n", $l, $r);
   $$ = $l;
  }
| exp[x] '+' { $<ival>$ = $x; } [l] exp[r]  { $$ = $<ival>l + $r;    }
| exp[l] '-' exp[r]  { $$ = $l - $r;        }
| exp[l] '*' exp[r]  { $$ = $l * $r;        }
| exp[l] '/' exp[r]  { $$ = $l / $r;        }
| '-' exp  %prec NEG { $$ = -$2;            }
| exp[l] '^' exp[r]  { $$ = power ($l, $r); }
| '(' exp[e] ')'     { $$ = $e;           }
| '(' error ')'      { $$ = 1111; yyerrok;  }
| '!'                { $$ = 0; YYERROR;     }
| '-' error          { $$ = 0; YYERROR;     }
;
%%




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
static int get_char (void)
{
  return getc (input);
}

static void unget_char (int c)
{
  ungetc (c, input);
}

static int read_signed_integer (void)
{
  int c = get_char ();
  int sign = 1;
  int n = 0;
  if (c == '-')
    {
      c = get_char ();
      sign = -1;
    }
  while (isdigit (c))
    {
      n = 10 * n + (c - '0');
      c = get_char ();
    }
  unget_char ( c);
  return sign * n;
}

static int
yylex (void)
{
  int c;
  /* Skip white space.  */
  while ((c = get_char ()) == ' ' || c == '\t') {}

  /* process numbers   */
  if (c == '.' || isdigit (c))
    {
      unget_char ( c);
      (yylval).ival = read_signed_integer ();
      return NUM;
    }

  /* Return end-of-file.  */
  if (c == EOF)
    return CALC_EOF;

  /* Return single chars. */
  return c;
}

static int power (int base, int exponent)
{
  int res = 1;
  assert (0 <= exponent);
  for (/* Niente */; exponent; --exponent)
    res *= base;
  return res;
}

int main (int argc, const char **argv)
{
  semantic_value result = 0;
  int count = 0;
  int status;
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
  fclose (input);
  assert (global_result == result); (void) global_result; (void) result;
  assert (global_count == count);   (void) global_count;  (void) count;
  return status;
}
