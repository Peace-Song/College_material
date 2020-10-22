%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
  #define YYSTACKEXPANDABLE 0
  typedef struct count_node {
    int count;
    struct count_node *prev;
  } count_node;
  static count_node *tail;
%}

%define parse.assert
%glr-parser
%union { count_node *node; }
%type <node> 'a'

%destructor {
  if ($$->count++)
    fprintf (stderr, "Destructor called on same value twice.\n");
} 'a'

%%

start:
    stack1 start
  | stack2 start
  | %empty
  ;
stack1: 'a' ;
stack2: 'a' ;

%%

static int
yylex (void)
{
  yylval.node = YY_CAST (count_node*, malloc (sizeof *yylval.node));
  if (!yylval.node)
    {
      fprintf (stderr, "Test inconclusive.\n");
      exit (EXIT_FAILURE);
    }
  yylval.node->count = 0;
  yylval.node->prev = tail;
  tail = yylval.node;
  return 'a';
}





/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
int
main (void)
{
  int status = yyparse ();
  while (tail)
    {
      count_node *prev = tail->prev;
      free (tail);
      tail = prev;
    }
  return status;
}
