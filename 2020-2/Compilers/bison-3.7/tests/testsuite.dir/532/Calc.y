/* Infix notation calculator--calc */
%define api.prefix {Calc}
%define api.parser.class {Calc}
%define public

%language "Java" %define parse.trace %define parse.error verbose %locations %lex-param {InputStream is}

%code imports {
  import java.io.BufferedReader;
  import java.io.IOException;
  import java.io.InputStream;
  import java.io.InputStreamReader;
  import java.io.Reader;
  import java.io.StreamTokenizer;
}

%code {
  public static void main (String[] args) throws IOException
  {
    Calc p = new Calc (System.in);
    p.setDebugLevel (1);
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
      yyerror (@$, "calc: error: " + $1 + " != " + $3);
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
%code lexer {
  StreamTokenizer st;
  PositionReader reader;

  public YYLexer (InputStream is)
  {
    reader = new PositionReader (new InputStreamReader (is));
    st = new StreamTokenizer (reader);
    st.resetSyntax ();
    st.eolIsSignificant (true);
    st.wordChars ('0', '9');
  }


  Position start = new Position (1, 0);
  Position end = new Position (1, 0);

  public Position getStartPos () {
    return new Position (start);
  }

  public Position getEndPos () {
    return new Position (end);
  }


  public void yyerror (Calc.Location l, String m)
  {
    if (l == null)
      System.err.println(m);
    else
      System.err.println(l + ": " + m);
  }





  Integer yylval;

  public Object getLVal () {
    return yylval;
  }

  public int yylex () throws IOException {;
    start.set (reader.getPosition ());
    int tkind = st.nextToken ();
    end.set (reader.getPosition ());
    switch (tkind)
      {
      case StreamTokenizer.TT_EOF:
        return CALC_EOF;
      case StreamTokenizer.TT_EOL:;
        end.line += 1;
        end.column = 0;
        return (int) '\n';
      case StreamTokenizer.TT_WORD:
        yylval = new Integer (st.sval);
        end.set (reader.getPreviousPosition ());
        return NUM;
      case ' ': case '\t':
        return yylex ();
      case '#':
        System.err.println(start + ": " + "syntax error: invalid character: '#'");
        return YYerror;
      default:
        return tkind;
      }
  }

};


%%
class Position {
  public int line = 1;
  public int column = 1;

  public Position ()
  {
    line = 1;
    column = 1;
  }

  public Position (int l, int t)
  {
    line = l;
    column = t;
  }

  public Position (Position p)
  {
    line = p.line;
    column = p.column;
  }

  public void set (Position p)
  {
    line = p.line;
    column = p.column;
  }

  public boolean equals (Position l)
  {
    return l.line == line && l.column == column;
  }

  public String toString ()
  {
    return Integer.toString (line) + "." + Integer.toString (column);
  }

  public int line ()
  {
    return line;
  }

  public int column ()
  {
    return column;
  }
}

class PositionReader extends BufferedReader {

  private Position position = new Position ();
  private Position previousPosition = new Position ();

  public PositionReader (Reader reader) {
    super (reader);
  }

  public int read () throws IOException {
    int res = super.read ();
    previousPosition.set (position);
    if (res > -1) {
      char c = (char)res;
      if (c == '\r' || c == '\n') {
        position.line += 1;
        position.column = 1;
      } else {
        position.column += 1;
      }
    }
    return res;
  }

  public Position getPosition () {
    return position;
  }

  public Position getPreviousPosition () {
    return previousPosition;
  }
}
