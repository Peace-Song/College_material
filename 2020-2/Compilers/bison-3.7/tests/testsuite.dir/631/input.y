%language "Java"
%initial-action {
System.err.println("Initial action invoked");
}


%define api.parser.class {YYParser}
%define parse.error verbose
%define parse.trace

%code imports {
import java.io.*;
import java.util.*;
}

%%

start: 'a' 'b' 'c' ;

%%


  public class Main
  {


  static class YYerror implements YYParser.Lexer
  {
    public Object getLVal() {return null;}
    public int yylex () throws java.io.IOException { return 0; }
    public void yyerror (String msg) { System.err.println(msg); }
  }

  static YYParser parser = null;
  static YYerror yyerror = null;
  static int teststate = -1;

  static void setup()
    throws IOException
  {
      yyerror = new YYerror();
      parser = new YYParser(yyerror);
      parser.setDebugLevel(1);
      teststate = -1;
  }

  static String[] teststatename
    = new String[]{"YYACCEPT","YYABORT","YYERROR","UNKNOWN","YYPUSH_MORE"};

  static void check(int teststate, int expected, String msg)
  {
    System.err.println("teststate="+teststatename[teststate]
                       +"; expected="+teststatename[expected]);
    if (teststate != expected)
        {
            System.err.println("unexpected state: "+msg);
            System.exit(1);
        }
  }


  static public void main (String[] args)
    throws IOException
  {
      setup();

      teststate = parser.push_parse('a', null);
      check(teststate,YYParser.YYPUSH_MORE,"push_parse('a', null)");
      teststate = parser.push_parse('b', null);
      check(teststate,YYParser.YYPUSH_MORE,"push_parse('b', null)");
      teststate = parser.push_parse('c', null);
      check(teststate,YYParser.YYPUSH_MORE,"push_parse('c', null)");
      teststate = parser.push_parse('\0', null);
      check(teststate,YYParser.YYACCEPT,"push_parse('\\0', null)");

      System.exit(0);
  }

}

