%skeleton "lalr1.d"
%debug



%union {
  int val;
}
%token <val> NUM "number"
%nterm <val> exp


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
: exp         { printf ("%d\n", $1); }
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
/* An error reporting function.  */
public void yyerror (string m)
{
  stderr.writeln (m);
}
import std.range.primitives;
import std.stdio;

auto yyLexer(R)(R range)
  if (isInputRange!R && is (ElementType!R : dchar))
{
  return new YYLexer!R(range);
}

auto yyLexer ()
{
  return yyLexer("0-(1+2)*3/9");
}

class YYLexer(R) : Lexer
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
  public final @property YYSemanticType semanticVal ()
  {
    return semanticVal_;
  }

  int yylex ()
  {
    import std.uni : isNumber;
    // Handle EOF.
    if (input.empty)
      return TokenKind.END;

    auto c = input.front;
    input.popFront;

    // Numbers.
    switch (c)
    {
    case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
      semanticVal_.val = c - '0';
      return TokenKind.NUM;
    case '+': return TokenKind.PLUS;
    case '-': return TokenKind.MINUS;
    case '*': return TokenKind.STAR;
    case '/': return TokenKind.SLASH;
    case '(': return TokenKind.LPAR;
    case ')': return TokenKind.RPAR;
    default: assert(0);
    }
  }
}

int main ()
{
  auto l = yyLexer ();
  auto p = new YYParser (l);
  return !p.parse ();
}
