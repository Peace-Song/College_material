%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

/* Simplified C++ Type and Expression Grammar.  */

%define api.pure

%code requires
{
  #include <stdio.h>
  union Node {
    struct {
      int isNterm;
      int parents;
    } nodeInfo;
    struct {
      int isNterm; /* 1 */
      int parents;
      char const *form;
      union Node *children[3];
    } nterm;
    struct {
      int isNterm; /* 0 */
      int parents;
      char *text;
    } term;
  };
  typedef union Node Node;
  #define YYSTYPE Node *
}

%code
{
  static Node *new_nterm (char const *, Node *, Node *, Node *);
  static Node *new_term (char *);
  static void free_node (Node *);
  static char *node_to_string (Node *);

  #define YYINITDEPTH 10
  #define YYSTACKEXPANDABLE 1
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (YYSTYPE *lvalp);
}

%token TYPENAME ID

%right '='
%left '+'

%glr-parser

%destructor { free_node ($$); } stmt expr decl declarator TYPENAME ID

%%

prog :
     | prog stmt   {
                        char *output;
                        output = node_to_string ($2);
                        printf ("%s\n", output);
                        free (output);
                        free_node ($2);
                   }
     ;

stmt : expr ';'  %dprec 1     { $$ = $1; }
     | decl      %dprec 2
     | error ';'        { $$ = new_nterm ("<error>", YY_NULLPTR, YY_NULLPTR, YY_NULLPTR); }
     | '@'              { YYACCEPT; }
     ;

expr : ID
     | TYPENAME '(' expr ')'
                        { $$ = new_nterm ("<cast>(%s,%s)", $3, $1, YY_NULLPTR); }
     | expr '+' expr    { $$ = new_nterm ("+(%s,%s)", $1, $3, YY_NULLPTR); }
     | expr '=' expr    { $$ = new_nterm ("=(%s,%s)", $1, $3, YY_NULLPTR); }
     ;

decl : TYPENAME declarator ';'
                        { $$ = new_nterm ("<declare>(%s,%s)", $1, $2, YY_NULLPTR); }
     | TYPENAME declarator '=' expr ';'
                        { $$ = new_nterm ("<init-declare>(%s,%s,%s)", $1,
                                          $2, $4); }
     ;

declarator : ID
     | '(' declarator ')' { $$ = $2; }
     ;

%%

#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <assert.h>

int
main (int argc, char **argv)
{
  assert (argc == 2); (void) argc;
  if (!freopen (argv[1], "r", stdin))
    return 3;
  return yyparse ();
}





/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}

int yylex (YYSTYPE *lvalp)
{
  static int lineNum = 1;
  static int colNum = 0;

#if YYPURE
# undef yylloc
# define yylloc (*llocp)
# undef yylval
# define yylval (*lvalp)
#endif

  while (1)
    {
      int c;
      assert (!feof (stdin));
      c = getchar ();
      switch (c)
        {
        case EOF:
          return 0;
        case '\t':
          colNum = (colNum + 7) & ~7;
          break;
        case ' ': case '\f':
          colNum += 1;
          break;
        case '\n':
          lineNum += 1;
          colNum = 0;
          break;
        default:
          {
            int tok;
            if (isalpha (c))
              {
                char buffer[256];
                unsigned i = 0;

                do
                  {
                    buffer[i++] = YY_CAST (char, c);
                    colNum += 1;
                    assert (i != sizeof buffer - 1);
                    c = getchar ();
                  }
                while (isalnum (c) || c == '_');

                ungetc (c, stdin);
                buffer[i++] = 0;
                tok = isupper (YY_CAST (unsigned char, buffer[0])) ? TYPENAME : ID;
                yylval = new_term (strcpy (YY_CAST (char *, malloc (i)), buffer));
              }
            else
              {
                colNum += 1;
                tok = c;
                yylval = YY_NULLPTR;
              }
            return tok;
          }
        }
    }
}

static Node *
new_nterm (char const *form, Node *child0, Node *child1, Node *child2)
{
  Node *node = YY_CAST (Node *, malloc (sizeof (Node)));
  node->nterm.isNterm = 1;
  node->nterm.parents = 0;
  node->nterm.form = form;
  node->nterm.children[0] = child0;
  if (child0)
    child0->nodeInfo.parents += 1;
  node->nterm.children[1] = child1;
  if (child1)
    child1->nodeInfo.parents += 1;
  node->nterm.children[2] = child2;
  if (child2)
    child2->nodeInfo.parents += 1;
  return node;
}

static Node *
new_term (char *text)
{
  Node *node = YY_CAST (Node *, malloc (sizeof (Node)));
  node->term.isNterm = 0;
  node->term.parents = 0;
  node->term.text = text;
  return node;
}

static void
free_node (Node *node)
{
  if (!node)
    return;
  node->nodeInfo.parents -= 1;
  /* Free only if 0 (last parent) or -1 (no parents).  */
  if (node->nodeInfo.parents > 0)
    return;
  if (node->nodeInfo.isNterm == 1)
    {
      free_node (node->nterm.children[0]);
      free_node (node->nterm.children[1]);
      free_node (node->nterm.children[2]);
    }
  else
    free (node->term.text);
  free (node);
}

static char *
node_to_string (Node *node)
{
  char *res;
  if (!node)
    {
      res = YY_CAST (char *, malloc (1));
      res[0] = 0;
    }
  else if (node->nodeInfo.isNterm == 1)
    {
      char *child0 = node_to_string (node->nterm.children[0]);
      char *child1 = node_to_string (node->nterm.children[1]);
      char *child2 = node_to_string (node->nterm.children[2]);
      res = YY_CAST (char *, malloc (strlen (node->nterm.form) + strlen (child0)
                                     + strlen (child1) + strlen (child2) + 1));
      sprintf (res, node->nterm.form, child0, child1, child2);
      free (child2);
      free (child1);
      free (child0);
    }
  else
    res = strdup (node->term.text);
  return res;
}



