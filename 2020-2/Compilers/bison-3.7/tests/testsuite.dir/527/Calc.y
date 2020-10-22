/* Infix notation calculator--calc */
%define api.prefix {Calc}
%define api.parser.class {Calc}
%define public

%language "Java" %define parse.error verbose

%code imports {
  import java.io.IOException;
  import java.io.InputStream;
  import java.io.InputStreamReader;
  import java.io.Reader;
  import java.io.StreamTokenizer;
}

%code {
  public static void main (String[] args) throws IOException
  {
    CalcLexer l = new CalcLexer (System.in);
    Calc p = new Calc (l);
    boolean success = p.parse ();
    if (!success)
      System.exit (1);
  }



}

/* Bison Declarations */
%token CALC_EOF 0 "end of input"
%token <Integer> NUM "number"
%type  <Integer> exp

%nonassoc '='       /* comparison            */
%left '-' '+'
%left '*' '/'
%precedence NEG     /* negation--unary minus */
%right '^'          /* exponentiation        */

/* Grammar follows */
%%
input:
  line
| input line
;

line:
  '\n'
| exp '\n'
;

exp:
  NUM
| exp '=' exp
  {
    if ($1.intValue () != $3.intValue ())
      yyerror ("calc: error: " + $1 + " != " + $3);
  }
| exp '+' exp        { $$ = $1 + $3; }
| exp '-' exp        { $$ = $1 - $3; }
| exp '*' exp        { $$ = $1 * $3; }
| exp '/' exp        { $$ = $1 / $3; }
| '-' exp  %prec NEG { $$ = -$2; }
| exp '^' exp        { $$ = (int) Math.pow ($1, $3); }
| '(' exp ')'        { $$ = $2; }
| '(' error ')'      { $$ = 1111; }
| '!'                { $$ = 0; return YYERROR; }
| '-' error          { $$ = 0; return YYERROR; }
;
%code epilogue { class CalcLexer implements Calc.Lexer {
  StreamTokenizer st;

  public CalcLexer (InputStream is)
  {
    st = new StreamTokenizer (new InputStreamReader (is));
    st.resetSyntax ();
    st.eolIsSignificant (true);
    st.wordChars ('0', '9');
  }



  public void yyerror (String m)
  {
    System.err.println (m);
  }





  Integer yylval;

  public Object getLVal () {
    return yylval;
  }

  public int yylex () throws IOException {;
    int tkind = st.nextToken ();
    switch (tkind)
      {
      case StreamTokenizer.TT_EOF:
        return CALC_EOF;
      case StreamTokenizer.TT_EOL:;
        return (int) '\n';
      case StreamTokenizer.TT_WORD:
        yylval = new Integer (st.sval);
        return NUM;
      case ' ': case '\t':
        return yylex ();
      case '#':
        System.err.println("syntax error: invalid character: '#'");
        return YYerror;
      default:
        return tkind;
      }
  }
}
};


