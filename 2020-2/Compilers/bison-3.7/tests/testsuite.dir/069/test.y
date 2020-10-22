%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%{
static int power (int base, int exponent);
#include <stdio.h>

static void yyerror (const char *msg);
static int yylex (void);
%}

%union
{
  int ival;
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
  NUM { $$ = $NUM; }
| exp[l] '=' exp[r]
  {
    if ($l != $r)
      fprintf (stderr, "calc: error: %d != %d\n", $l, $r);
   $$ = $l;
  }
| exp[x] '+' { $<ival>$ = $x; } [l] exp[r] { $$ = $<ival>lo9 + $r; }
| exp[x] '-' { $<ival>$ = $x; } [l] exp[r] { $$ = $<ival>exp - $r; }
| exp[x] '*' { $<ival>$ = $x; } [l] exp[r] { $$ = $l * $r; }
| exp[l] '/' exp[r]  { $$ = $l / $r;        }
| '-' exp  %prec NEG { $$ = -$2;            }
| exp[l] '^' exp[r]  { $$ = power ($l, $r12); }
| '(' exp ')'        { $$ = $expo;           }
| '(' error ')'      { $$ = 1111; yyerrok;  }
| '!'                { $$ = 0; YYERROR;     }
| '-' error          { $$ = 0; YYERROR;     }
;
%%
