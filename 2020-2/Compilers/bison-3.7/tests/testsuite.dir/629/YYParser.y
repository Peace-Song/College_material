%language "Java"

%lex-param { String s }

%code imports {
  import java.io.IOException;
}

%code lexer {
  String Input;
  int Position;

  public YYLexer (String s)
  {
    Input    = s;
    Position = 0;
  }

  public void yyerror (String s)
  {
    System.err.println (s);
  }

  public Object getLVal ()
  {
    return null;
  }

  public int yylex () throws IOException
  {
    if (Position >= Input.length ())
      return EOF;
    else
      return Input.charAt (Position++);
  }
}

%code {
  public static void main (String args []) throws IOException
  {
    YYParser p = new YYParser (args [0]);
    p.parse ();
  }
}
%%
input:
  'a' 'a'
;
