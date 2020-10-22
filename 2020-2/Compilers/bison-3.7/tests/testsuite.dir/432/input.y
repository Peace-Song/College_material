%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%skeleton "glr.cc" %define api.token.raw
%debug

%code
{
#include <stdio.h>

static int yylex (yy::parser::semantic_type *lvalp);
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
/* A C++ error reporting function.  */
void
yy::parser::error (const std::string& m)
{
  std::cerr << m << '\n';
}
#include <stdlib.h> /* abort */
int yylex (yy::parser::semantic_type *lvalp)
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
      (*lvalp).val = c - '0';
      return yy::parser::token::NUM;
    case '+': return yy::parser::token::PLUS;
    case '-': return yy::parser::token::MINUS;
    case '*': return yy::parser::token::STAR;
    case '/': return yy::parser::token::SLASH;
    case '(': return yy::parser::token::LPAR;
    case ')': return yy::parser::token::RPAR;
    case 0:   return yy::parser::token::END;
    }
  abort ();
}

#include <cstdlib> // getenv.
#include <cstring> // strcmp.
int
main (int argc, char const* argv[])
{
  yy::parser p;
  int debug = !!getenv ("YYDEBUG");
  for (int i = 1; i < argc; ++i)
    if (!strcmp (argv[i], "-p")
        || !strcmp (argv[i], "-d") || !strcmp (argv[i], "--debug"))
      debug |= 1;
    else if (!strcmp (argv[i], "-s") || !strcmp (argv[i], "--stat"))
      debug |= 2;
  p.set_debug_level (debug);
  return p.parse ();
}
