

%code imports {
  import java.io.IOException;
}



%define lr.type ielr
                             %language "java"

%define parse.error verbose

%%

%nonassoc 'a';

start: consistent-error-on-a-a 'a' ;

consistent-error-on-a-a:
    'a' default-reduction
  | 'a' default-reduction 'a'
  | 'a' shift
  ;

default-reduction: %empty ;
shift: 'b' ;

// Provide another context in which all rules are useful so that this
// test case looks a little more realistic.
start: 'b' consistent-error-on-a-a 'c' ;


%code lexer {

  /*--------.
  | yylex.  |
  `--------*/

  public String input = "a";
  public int index = 0;
  public int yylex ()
  {
    if (index < input.length ())
      return input.charAt (index++);
    else
      return 0;
  }
  public Object getLVal ()
  {
    return new Integer(1);
  }


  public void yyerror (String m)
  {
    System.err.println (m);
  }




};
%%


/*-------.
| main.  |
`-------*/
class input
{
  public static void main (String[] args) throws IOException
  {
    YYParser p = new YYParser ();
    boolean success = p.parse ();
    if (!success)
      System.exit (1);
  }
}
