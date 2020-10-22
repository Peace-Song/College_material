%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%skeleton "glr.c"
%debug

%code
{
#include <stdio.h>
#include <stdio.h>

static void yyerror (const char *msg);
static int yylex (void);
}


%union {
  int val;
}
%token <val> NUM "number"
%nterm <val> exp


%token
  PLUS  "+"
  MINUS "-"
  STAR  "*"
  SLASH "/"
  LPAR  "("
  RPAR  ")"
  END   0

%left "+" "-"
%left "*" "/"

%%

input
: exp         { printf ("%d\n", $1); }
;

exp
: exp "+" exp { $$ = $1 + $3; }
| exp "-" exp { $$ = $1 - $3; }
| exp "*" exp { $$ = $1 * $3; }
| exp "/" exp { $$ = $1 / $3; }
| "(" exp ")" { $$ = $2; }
| "number"    { $$ = $1; }
;

%%




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
#include <stdlib.h> /* abort */
int yylex (void)
{
  static const char* input = "0-(1+2)*3/9";
  int c = *input++;
  switch (c)
    {
    case '0':
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      (yylval).val = c - '0';
      return NUM;
    case '+': return PLUS;
    case '-': return MINUS;
    case '*': return STAR;
    case '/': return SLASH;
    case '(': return LPAR;
    case ')': return RPAR;
    case 0:   return 0;
    }
  abort ();
}

#include <stdlib.h> /* getenv. */
#include <string.h> /* strcmp. */
int
main (int argc, char const* argv[])
{
  yydebug = !!getenv ("YYDEBUG");
  for (int i = 1; i < argc; ++i)
    if (!strcmp (argv[i], "-p")
        || !strcmp (argv[i], "-d") || !strcmp (argv[i], "--debug"))
      yydebug |= 1;
    else if (!strcmp (argv[i], "-s") || !strcmp (argv[i], "--stat"))
      yydebug |= 2;
  return yyparse ();
}
