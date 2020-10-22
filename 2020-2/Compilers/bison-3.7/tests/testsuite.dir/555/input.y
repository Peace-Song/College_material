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

%define lr.type lalr
%define parse.error verbose

%token LABEL
%token VARIABLE
%token NUMBER
%token TEXT
%token COMMAND_LINE
%token DELIMITED
%token ORDINAL
%token TH
%token LEFT_ARROW_HEAD
%token RIGHT_ARROW_HEAD
%token DOUBLE_ARROW_HEAD
%token LAST
%token UP
%token DOWN
%token LEFT
%token RIGHT
%token BOX
%token CIRCLE
%token ELLIPSE
%token ARC
%token LINE
%token ARROW
%token MOVE
%token SPLINE
%token HEIGHT
%token RADIUS
%token WIDTH
%token DIAMETER
%token FROM
%token TO
%token AT
%token WITH
%token BY
%token THEN
%token SOLID
%token DOTTED
%token DASHED
%token CHOP
%token SAME
%token INVISIBLE
%token LJUST
%token RJUST
%token ABOVE
%token BELOW
%token OF
%token THE
%token WAY
%token BETWEEN
%token AND
%token HERE
%token DOT_N
%token DOT_E
%token DOT_W
%token DOT_S
%token DOT_NE
%token DOT_SE
%token DOT_NW
%token DOT_SW
%token DOT_C
%token DOT_START
%token DOT_END
%token DOT_X
%token DOT_Y
%token DOT_HT
%token DOT_WID
%token DOT_RAD
%token SIN
%token COS
%token ATAN2
%token LOG
%token EXP
%token SQRT
%token K_MAX
%token K_MIN
%token INT
%token RAND
%token SRAND
%token COPY
%token THROUGH
%token TOP
%token BOTTOM
%token UPPER
%token LOWER
%token SH
%token PRINT
%token CW
%token CCW
%token FOR
%token DO
%token IF
%token ELSE
%token ANDAND
%token OROR
%token NOTEQUAL
%token EQUALEQUAL
%token LESSEQUAL
%token GREATEREQUAL
%token LEFT_CORNER
%token RIGHT_CORNER
%token NORTH
%token SOUTH
%token EAST
%token WEST
%token CENTER
%token END
%token START
%token RESET
%token UNTIL
%token PLOT
%token THICKNESS
%token FILL
%token COLORED
%token OUTLINED
%token SHADED
%token ALIGNED
%token SPRINTF
%token COMMAND

%left '.'

/* this ensures that plot 17 "%g" parses as (plot 17 "%g") */
%left PLOT
%left TEXT SPRINTF

/* give text adjustments higher precedence than TEXT, so that
box "foo" above ljust == box ("foo" above ljust)
*/

%left LJUST RJUST ABOVE BELOW

%left LEFT RIGHT
/* Give attributes that take an optional expression a higher
precedence than left and right, so that eg 'line chop left'
parses properly. */
%left CHOP SOLID DASHED DOTTED UP DOWN FILL COLORED OUTLINED
%left LABEL

%left VARIABLE NUMBER '(' SIN COS ATAN2 LOG EXP SQRT K_MAX K_MIN INT RAND SRAND LAST
%left ORDINAL HERE '`'

%left BOX CIRCLE ELLIPSE ARC LINE ARROW SPLINE '[' /* ] */

/* these need to be lower than '-' */
%left HEIGHT RADIUS WIDTH DIAMETER FROM TO AT THICKNESS

/* these must have higher precedence than CHOP so that 'label %prec CHOP'
works */
%left DOT_N DOT_E DOT_W DOT_S DOT_NE DOT_SE DOT_NW DOT_SW DOT_C
%left DOT_START DOT_END TOP BOTTOM LEFT_CORNER RIGHT_CORNER
%left UPPER LOWER NORTH SOUTH EAST WEST CENTER START END

%left ','
%left OROR
%left ANDAND
%left EQUALEQUAL NOTEQUAL
%left '<' '>' LESSEQUAL GREATEREQUAL

%left BETWEEN OF
%left AND

%left '+' '-'
%left '*' '/' '%'
%right '!'
%right '^'


%%


top:
        optional_separator
        | element_list
        ;

element_list:
        optional_separator middle_element_list optional_separator
        ;

middle_element_list:
        element
        | middle_element_list separator element
        ;

optional_separator:
        /* empty */
        | separator
        ;

separator:
        ';'
        | separator ';'
        ;

placeless_element:
        VARIABLE '=' any_expr
        | VARIABLE ':' '=' any_expr
        | UP
        | DOWN
        | LEFT
        | RIGHT
        | COMMAND_LINE
        | COMMAND print_args
        | PRINT print_args
        | SH
                {}
          DELIMITED
        | COPY TEXT
        | COPY TEXT THROUGH
                {}
          DELIMITED
                {}
          until
        | COPY THROUGH
                {}
          DELIMITED
                {}
          until
        | FOR VARIABLE '=' expr TO expr optional_by DO
                {}
          DELIMITED
        | simple_if
        | simple_if ELSE
                {}
          DELIMITED
        | reset_variables
        | RESET
        ;

reset_variables:
        RESET VARIABLE
        | reset_variables VARIABLE
        | reset_variables ',' VARIABLE
        ;

print_args:
        print_arg
        | print_args print_arg
        ;

print_arg:
        expr                                                    %prec ','
        | text
        | position                                              %prec ','
        ;

simple_if:
        IF any_expr THEN
                {}
        DELIMITED
        ;

until:
        /* empty */
        | UNTIL TEXT
        ;

any_expr:
        expr
        | text_expr
        ;

text_expr:
        text EQUALEQUAL text
        | text NOTEQUAL text
        | text_expr ANDAND text_expr
        | text_expr ANDAND expr
        | expr ANDAND text_expr
        | text_expr OROR text_expr
        | text_expr OROR expr
        | expr OROR text_expr
        | '!' text_expr
        ;

optional_by:
        /* empty */
        | BY expr
        | BY '*' expr
        ;

element:
        object_spec
        | LABEL ':' optional_separator element
        | LABEL ':' optional_separator position_not_place
        | LABEL ':' optional_separator place
        | '{' {} element_list '}'
                {}
          optional_element
        | placeless_element
        ;

optional_element:
        /* empty */
        | element
        ;

object_spec:
        BOX
        | CIRCLE
        | ELLIPSE
        | ARC
        | LINE
        | ARROW
        | MOVE
        | SPLINE
        | text                                                  %prec TEXT
        | PLOT expr
        | PLOT expr text
        | '['
                {}
          element_list ']'
        | object_spec HEIGHT expr
        | object_spec RADIUS expr
        | object_spec WIDTH expr
        | object_spec DIAMETER expr
        | object_spec expr                                      %prec HEIGHT
        | object_spec UP
        | object_spec UP expr
        | object_spec DOWN
        | object_spec DOWN expr
        | object_spec RIGHT
        | object_spec RIGHT expr
        | object_spec LEFT
        | object_spec LEFT expr
        | object_spec FROM position
        | object_spec TO position
        | object_spec AT position
        | object_spec WITH path
        | object_spec WITH position                             %prec ','
        | object_spec BY expr_pair
        | object_spec THEN
        | object_spec SOLID
        | object_spec DOTTED
        | object_spec DOTTED expr
        | object_spec DASHED
        | object_spec DASHED expr
        | object_spec FILL
        | object_spec FILL expr
        | object_spec SHADED text
        | object_spec COLORED text
        | object_spec OUTLINED text
        | object_spec CHOP
        | object_spec CHOP expr
        | object_spec SAME
        | object_spec INVISIBLE
        | object_spec LEFT_ARROW_HEAD
        | object_spec RIGHT_ARROW_HEAD
        | object_spec DOUBLE_ARROW_HEAD
        | object_spec CW
        | object_spec CCW
        | object_spec text                                      %prec TEXT
        | object_spec LJUST
        | object_spec RJUST
        | object_spec ABOVE
        | object_spec BELOW
        | object_spec THICKNESS expr
        | object_spec ALIGNED
        ;

text:
        TEXT
        | SPRINTF '(' TEXT sprintf_args ')'
        ;

sprintf_args:
        /* empty */
        | sprintf_args ',' expr
        ;

position:
        position_not_place
        | place
        ;

position_not_place:
        expr_pair
        | position '+' expr_pair
        | position '-' expr_pair
        | '(' position ',' position ')'
        | expr between position AND position
        | expr '<' position ',' position '>'
        ;

between:
        BETWEEN
        | OF THE WAY BETWEEN
        ;

expr_pair:
        expr ',' expr
        | '(' expr_pair ')'
        ;

place:
        /* line at A left == line (at A) left */
        label                                                   %prec CHOP
        | label corner
        | corner label
        | corner OF label
        | HERE
        ;

label:
        LABEL
        | nth_primitive
        | label '.' LABEL
        ;

ordinal:
        ORDINAL
        | '`' any_expr TH
        ;

optional_ordinal_last:
        LAST
        | ordinal LAST
        ;

nth_primitive:
        ordinal object_type
        | optional_ordinal_last object_type
        ;

object_type:
        BOX
        | CIRCLE
        | ELLIPSE
        | ARC
        | LINE
        | ARROW
        | SPLINE
        | '[' ']'
        | TEXT
        ;

label_path:
        '.' LABEL
        | label_path '.' LABEL
        ;

relative_path:
        corner                                                  %prec CHOP
        /* give this a lower precedence than LEFT and RIGHT so that
           [A: box] with .A left == [A: box] with (.A left) */
        | label_path                                            %prec TEXT
        | label_path corner
        ;

path:
        relative_path
        | '(' relative_path ',' relative_path ')'
                {}
        /* The rest of these rules are a compatibility sop. */
        | ORDINAL LAST object_type relative_path
        | LAST object_type relative_path
        | ORDINAL object_type relative_path
        | LABEL relative_path
        ;

corner:
        DOT_N
        | DOT_E
        | DOT_W
        | DOT_S
        | DOT_NE
        | DOT_SE
        | DOT_NW
        | DOT_SW
        | DOT_C
        | DOT_START
        | DOT_END
        | TOP
        | BOTTOM
        | LEFT
        | RIGHT
        | UPPER LEFT
        | LOWER LEFT
        | UPPER RIGHT
        | LOWER RIGHT
        | LEFT_CORNER
        | RIGHT_CORNER
        | UPPER LEFT_CORNER
        | LOWER LEFT_CORNER
        | UPPER RIGHT_CORNER
        | LOWER RIGHT_CORNER
        | NORTH
        | SOUTH
        | EAST
        | WEST
        | CENTER
        | START
        | END
        ;

expr:
        VARIABLE
        | NUMBER
        | place DOT_X
        | place DOT_Y
        | place DOT_HT
        | place DOT_WID
        | place DOT_RAD
        | expr '+' expr
        | expr '-' expr
        | expr '*' expr
        | expr '/' expr
        | expr '%' expr
        | expr '^' expr
        | '-' expr                                              %prec '!'
        | '(' any_expr ')'
        | SIN '(' any_expr ')'
        | COS '(' any_expr ')'
        | ATAN2 '(' any_expr ',' any_expr ')'
        | LOG '(' any_expr ')'
        | EXP '(' any_expr ')'
        | SQRT '(' any_expr ')'
        | K_MAX '(' any_expr ',' any_expr ')'
        | K_MIN '(' any_expr ',' any_expr ')'
        | INT '(' any_expr ')'
        | RAND '(' any_expr ')'
        | RAND '(' ')'
        | SRAND '(' any_expr ')'
        | expr '<' expr
        | expr LESSEQUAL expr
        | expr '>' expr
        | expr GREATEREQUAL expr
        | expr EQUALEQUAL expr
        | expr NOTEQUAL expr
        | expr ANDAND expr
        | expr OROR expr
        | '!' expr
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
    VARIABLE, '=', LABEL, LEFT, DOT_X, 0
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
