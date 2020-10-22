%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

/* Infix notation calculator--calc */
%language "C++" %glr-parser %defines %define parse.error verbose %name-prefix "calc" %verbose

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


  int calclex (calc::parser::semantic_type *lvalp);


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
        yyparser.error (buf);
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
calc::parser::error (const std::string& m)
{
  std::cerr << m << '\n';
}
