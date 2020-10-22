%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%code {
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
}

%define lr.type canonical-lr
%define parse.error verbose

%token FUNC_CALL NAME REGEXP
%token ERROR
%token YNUMBER YSTRING
%token RELOP APPEND_OP
%token ASSIGNOP MATCHOP NEWLINE CONCAT_OP
%token LEX_BEGIN LEX_END LEX_IF LEX_ELSE LEX_RETURN LEX_DELETE
%token LEX_WHILE LEX_DO LEX_FOR LEX_BREAK LEX_CONTINUE
%token LEX_PRINT LEX_PRINTF LEX_NEXT LEX_EXIT LEX_FUNCTION
%token LEX_GETLINE LEX_NEXTFILE
%token LEX_IN
%token LEX_AND LEX_OR INCREMENT DECREMENT
%token LEX_BUILTIN LEX_LENGTH

/* Lowest to highest */
%right ASSIGNOP
%right '?' ':'
%left LEX_OR
%left LEX_AND
%left LEX_GETLINE
%nonassoc LEX_IN
%left FUNC_CALL LEX_BUILTIN LEX_LENGTH
%nonassoc ','
%nonassoc MATCHOP
%nonassoc RELOP '<' '>' '|' APPEND_OP TWOWAYIO
%left CONCAT_OP
%left YSTRING YNUMBER
%left '+' '-'
%left '*' '/' '%'
%right '!' UNARY
%right '^'
%left INCREMENT DECREMENT
%left '$'
%left '(' ')'


%%


start
        : opt_nls program opt_nls
        ;

program
        : rule
        | program rule
        | error
        | program error
        | /* empty */
        ;

rule
        : LEX_BEGIN {} action
        | LEX_END {}   action
        | LEX_BEGIN statement_term
        | LEX_END statement_term
        | pattern action
        | action
        | pattern statement_term
        | function_prologue function_body
        ;

func_name
        : NAME
        | FUNC_CALL
        | lex_builtin
        ;

lex_builtin
        : LEX_BUILTIN
        | LEX_LENGTH
        ;

function_prologue
        : LEX_FUNCTION {} func_name '(' opt_param_list r_paren opt_nls
        ;

function_body
        : l_brace statements r_brace opt_semi opt_nls
        | l_brace r_brace opt_semi opt_nls
        ;

pattern
        : exp
        | exp ',' exp
        ;

regexp
        /*
         * In this rule, want_regexp tells yylex that the next thing
         * is a regexp so it should read up to the closing slash.
         */
        : '/' {} REGEXP '/'
        ;

action
        : l_brace statements r_brace opt_semi opt_nls
        | l_brace r_brace opt_semi opt_nls
        ;

statements
        : statement
        | statements statement
        | error
        | statements error
        ;

statement_term
        : nls
        | semi opt_nls
        ;

statement
        : semi opt_nls
        | l_brace r_brace
        | l_brace statements r_brace
        | if_statement
        | LEX_WHILE '(' exp r_paren opt_nls statement
        | LEX_DO opt_nls statement LEX_WHILE '(' exp r_paren opt_nls
        | LEX_FOR '(' NAME LEX_IN NAME r_paren opt_nls statement
        | LEX_FOR '(' opt_exp semi opt_nls exp semi opt_nls opt_exp r_paren opt_nls statement
        | LEX_FOR '(' opt_exp semi opt_nls semi opt_nls opt_exp r_paren opt_nls statement
        | LEX_BREAK statement_term
        | LEX_CONTINUE statement_term
        | print '(' expression_list r_paren output_redir statement_term
        | print opt_rexpression_list output_redir statement_term
        | LEX_NEXT statement_term
        | LEX_NEXTFILE statement_term
        | LEX_EXIT opt_exp statement_term
        | LEX_RETURN {} opt_exp statement_term
        | LEX_DELETE NAME '[' expression_list ']' statement_term
        | LEX_DELETE NAME  statement_term
        | exp statement_term
        ;

print
        : LEX_PRINT
        | LEX_PRINTF
        ;

if_statement
        : LEX_IF '(' exp r_paren opt_nls statement
        | LEX_IF '(' exp r_paren opt_nls statement
             LEX_ELSE opt_nls statement
        ;

nls
        : NEWLINE
        | nls NEWLINE
        ;

opt_nls
        : /* empty */
        | nls
        ;

input_redir
        : /* empty */
        | '<' simp_exp
        ;

output_redir
        : /* empty */
        | '>' exp
        | APPEND_OP exp
        | '|' exp
        | TWOWAYIO exp
        ;

opt_param_list
        : /* empty */
        | param_list
        ;

param_list
        : NAME
        | param_list comma NAME
        | error
        | param_list error
        | param_list comma error
        ;

/* optional expression, as in for loop */
opt_exp
        : /* empty */
        | exp
        ;

opt_rexpression_list
        : /* empty */
        | rexpression_list
        ;

rexpression_list
        : rexp
        | rexpression_list comma rexp
        | error
        | rexpression_list error
        | rexpression_list error rexp
        | rexpression_list comma error
        ;

opt_expression_list
        : /* empty */
        | expression_list
        ;

expression_list
        : exp
        | expression_list comma exp
        | error
        | expression_list error
        | expression_list error exp
        | expression_list comma error
        ;

/* Expressions, not including the comma operator.  */
exp     : variable ASSIGNOP {} exp
        | '(' expression_list r_paren LEX_IN NAME
        | exp '|' LEX_GETLINE opt_variable
        | exp TWOWAYIO LEX_GETLINE opt_variable
        | LEX_GETLINE opt_variable input_redir
        | exp LEX_AND exp
        | exp LEX_OR exp
        | exp MATCHOP exp
        | regexp
        | '!' regexp %prec UNARY
        | exp LEX_IN NAME
        | exp RELOP exp
        | exp '<' exp
        | exp '>' exp
        | exp '?' exp ':' exp
        | simp_exp
        | exp simp_exp %prec CONCAT_OP
        ;

rexp
        : variable ASSIGNOP {} rexp
        | rexp LEX_AND rexp
        | rexp LEX_OR rexp
        | LEX_GETLINE opt_variable input_redir
        | regexp
        | '!' regexp %prec UNARY
        | rexp MATCHOP rexp
        | rexp LEX_IN NAME
        | rexp RELOP rexp
        | rexp '?' rexp ':' rexp
        | simp_exp
        | rexp simp_exp %prec CONCAT_OP
        ;

simp_exp
        : non_post_simp_exp
        /* Binary operators in order of decreasing precedence.  */
        | simp_exp '^' simp_exp
        | simp_exp '*' simp_exp
        | simp_exp '/' simp_exp
        | simp_exp '%' simp_exp
        | simp_exp '+' simp_exp
        | simp_exp '-' simp_exp
        | variable INCREMENT
        | variable DECREMENT
        ;

non_post_simp_exp
        : '!' simp_exp %prec UNARY
        | '(' exp r_paren
        | LEX_BUILTIN
          '(' opt_expression_list r_paren
        | LEX_LENGTH '(' opt_expression_list r_paren
        | LEX_LENGTH
        | FUNC_CALL '(' opt_expression_list r_paren
        | variable
        | INCREMENT variable
        | DECREMENT variable
        | YNUMBER
        | YSTRING
        | '-' simp_exp    %prec UNARY
        | '+' simp_exp    %prec UNARY
        ;

opt_variable
        : /* empty */
        | variable
        ;

variable
        : NAME
        | NAME '[' expression_list ']'
        | '$' non_post_simp_exp
        ;

l_brace
        : '{' opt_nls
        ;

r_brace
        : '}' opt_nls
        ;

r_paren
        : ')'
        ;

opt_semi
        : /* empty */
        | semi
        ;

semi
        : ';'
        ;

comma   : ',' opt_nls
        ;


%%




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
static int
yylex (void)
{
  static int const input[] = {
    LEX_GETLINE, '$', '!', YNUMBER, '*', YNUMBER, ';', 0
  };
  static int const *inputp = input;
  return *inputp++;
}

#include <stdlib.h> /* getenv. */
#include <string.h> /* strcmp. */
int
main (int argc, char const* argv[])
{
  (void) argc;
  (void) argv;
  return yyparse ();
}
