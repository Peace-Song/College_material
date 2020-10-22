%skeleton "lalr1.java" %define api.token.raw
%debug

%define api.prefix {Calc}
%define api.parser.class {Calc}
%code imports {
  import java.io.IOException;
  import java.io.InputStream;
  import java.io.StringReader;
  import java.io.Reader;
  import java.io.StreamTokenizer;
}


%token <Integer> NUM "number"
%type  <Integer> exp


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
: exp         { System.out.println ($1); }
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

class CalcLexer implements Calc.Lexer {

  StreamTokenizer st;

  public CalcLexer (InputStream is)
  {
    st = new StreamTokenizer (new StringReader ("0-(1+2)*3/9"));
    st.resetSyntax ();
    st.eolIsSignificant (true);
    st.whitespaceChars ('\t', '\t');
    st.whitespaceChars (' ', ' ');
    st.wordChars ('0', '9');
  }

  public void yyerror (String s)
  {
    System.err.println (s);
  }

  Integer yylval;

  public Object getLVal () {
    return yylval;
  }

  public int yylex () throws IOException {
    int ttype = st.nextToken ();
    switch (ttype)
      {
      case StreamTokenizer.TT_EOF:
        return EOF;
      case StreamTokenizer.TT_EOL:
        return (int) '\n';
      case StreamTokenizer.TT_WORD:
        yylval = new Integer (st.sval);
        return NUM;
      case '+':
        return PLUS;
      case '-':
        return MINUS;
      case '*':
        return STAR;
      case '/':
        return SLASH;
      case '(':
        return LPAR;
      case ')':
        return RPAR;
      default:
        throw new AssertionError ("invalid character: " + ttype);
      }
  }
}

class input
{
  public static void main (String[] args) throws IOException
  {
    CalcLexer l = new CalcLexer (System.in);
    Calc p = new Calc (l);
    //p.setDebugLevel (1);
    boolean success = p.parse ();
    if (!success)
      System.exit (1);
  }
}
