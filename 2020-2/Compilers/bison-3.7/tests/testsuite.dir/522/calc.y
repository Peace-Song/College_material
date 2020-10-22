/* Infix notation calculator--calc */
%language "D" %debug

%code imports {
  alias semantic_value = int;
}


/* Exercise %union. */
%union
{
  semantic_value ival;
};
%printer { fprintf (yyo, "%d", $$); } <ival>;





/* Bison Declarations */
%token CALC_EOF 0 "end of input"
%token <ival> NUM   "number"
%type  <ival> exp

%nonassoc '='   /* comparison          */
%left '-' '+'
%left '*' '/'
%precedence NEG /* negation--unary minus */
%right '^'      /* exponentiation        */

/* Grammar follows */
%%
input:
  line
| input line         {  }
;

line:
  '\n'
| exp '\n'           {  }
;

exp:
  NUM
| exp '=' exp
  {
    if ($1 != $3)
      yyerror (format ("calc: error: %d != %d", $1, $3));
    $$ = $1;
  }
| exp '+' exp        { $$ = $1 + $3; }
| exp '-' exp        { $$ = $1 - $3; }
| exp '*' exp        { $$ = $1 * $3; }
| exp '/' exp        { $$ = $1 / $3; }
| '-' exp  %prec NEG { $$ = -$2; }
| exp '^' exp        { $$ = power ($1, $3); }
| '(' exp ')'        { $$ = $2; }
| '(' error ')'      { $$ = 1111;  }
| '!'                { $$ = 0; return YYERROR; }
| '-' error          { $$ = 0; return YYERROR; }
;
%%

int
power (int base, int exponent)
{
  int res = 1;
  assert (0 <= exponent);
  for (/* Niente */; exponent; --exponent)
    res *= base;
  return res;
}


/* An error reporting function.  */
public void yyerror (string m)
{
  stderr.writeln (m);
}
import std.range.primitives;
import std.stdio;

auto calcLexer(R)(R range)
  if (isInputRange!R && is (ElementType!R : dchar))
{
  return new CalcLexer!R(range);
}

auto calcLexer (File f)
{
  import std.algorithm : map, joiner;
  import std.utf : byDchar;

  return f.byChunk(1024)        // avoid making a syscall roundtrip per char
          .map!(chunk => cast(char[]) chunk) // because byChunk returns ubyte[]
          .joiner               // combine chunks into a single virtual range of char
          .calcLexer;           // forward to other overload
}

class CalcLexer(R) : Lexer
  if (isInputRange!R && is (ElementType!R : dchar))
{
  R input;

  this(R r) {
    input = r;
  }

  /* An error reporting function.  */
public void yyerror (string m)
{
  stderr.writeln (m);
}

  YYSemanticType semanticVal_;
  public final @property YYSemanticType semanticVal()
  {
    return semanticVal_;
  }

  int parseInt ()
  {
    auto res = 0;
    import std.uni : isNumber;
    while (input.front.isNumber)
      {
        res = res * 10 + (input.front - '0');
        input.popFront;
      }
    return res;
  }

  int yylex ()
  {

    import std.uni : isWhite, isNumber;

    // Skip initial spaces
    while (!input.empty && input.front != '\n' && isWhite (input.front))
      {
        input.popFront;
      }

    // EOF.
    if (input.empty)
      return TokenKind.CALC_EOF;

    // Numbers.
    if (input.front.isNumber)
      {
        semanticVal_.ival = parseInt;
        return TokenKind.NUM;
      }

    // Individual characters
    auto c = input.front;
    input.popFront;

    // An explicit error raised by the scanner. */
    if (c == '#')
      {
        stderr.writeln ("syntax error: invalid character: '#'");
        return TokenKind.YYerror;
      }

    return c;
  }
}

int main (string[] args)
{

  File input = args.length == 2 ? File (args[1], "r") : stdin;
  auto l = calcLexer (input);
  auto p = new YYParser (l);
  p.setDebugLevel (1);
  return !p.parse ();
}
