%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

/* Regression Test: Improper handling of embedded actions and $-N  */
/* Reported by S. Eken */

%{
  #define YYSTYPE char *

  #include <ctype.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <assert.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
%}

%define parse.assert
%glr-parser

%%

command:
    's' var 't'
       { printf ("Variable: '%s'\n", $2); }
    'v' 'x' 'q'
       { free ($2); }
  | 's' var_list 't' 'e'
       { printf ("Varlist: '%s'\n", $2); free ($2); }
  | 's' var 't' var_printer 'x'
       { free ($2); }
  ;

var:
  'V'
     { $$ = $1; }
  ;

var_list:
  var
    { $$ = $1; }
  | var ',' var_list
    {
      char *s = YY_CAST (char *, realloc ($1, strlen ($1) + 1 + strlen ($3) + 1));
      strcat (s, ",");
      strcat (s, $3);
      free ($3);
      $$ = s;
    }
  ;

var_printer: 'v'
   { printf ("Variable: '%s'\n", $-1); }

%%




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
FILE *input;

int
yylex (void)
{
  char buf[50];
  assert (!feof (stdin));
  switch (fscanf (input, " %1[a-z,]", buf))
  {
  case 1:
    return buf[0];
  case EOF:
    return 0;
  default:
    if (fscanf (input, "%49s", buf) != 1)
      return 0;
    else
      {
        char *s;
        assert (strlen (buf) < sizeof buf - 1);
        s = YY_CAST (char *, malloc (strlen (buf) + 1));
        strcpy (s, buf);
        yylval = s;
        return 'V';
      }
    break;
  }
}

int
main (int argc, char **argv)
{
  int res;
  input = stdin;
  if (argc == 2 && !(input = fopen (argv[1], "r")))
    return 3;
  res = yyparse ();
  if (argc == 2 && fclose (input))
    return 4;
  return res;
}
