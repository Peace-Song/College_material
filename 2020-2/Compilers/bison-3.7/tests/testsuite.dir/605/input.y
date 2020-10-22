%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%skeleton "lalr1.cc"
%defines

%debug
%define parse.assert
%define api.value.type variant
%define api.token.constructor
%define parse.error verbose

%code
{
  #include <iostream>
  namespace yy
  {
    static yy::parser::symbol_type yylex();
  }
}

%token <int> NUMBER;
%type <int> expr;
%token EOI 0;
%printer { yyo << $$; } <int>;
%destructor { std::cerr << "destroy: " << $$ << '\n'; } <int>
%%
expr:
  NUMBER { $$ = $1 * 10; }
| expr <int>{ $$ = 20; } NUMBER
  {
    std::cerr << "expr: " << $1 << ' ' << $2 << ' ' << $3 << '\n';
    $$ = 40;
  }
;

%%
namespace yy
{
  parser::symbol_type yylex()
  {
    static int loc = 0;
    switch (loc++)
      {
      case 0:
        return parser::make_NUMBER (1);
      case 1:
        return parser::make_NUMBER (30);
      default:
        return parser::make_EOI ();
      }
  }

  void parser::error(const std::string& message)
  {
    std::cerr << message << '\n';
  }
}

int main()
{
  yy::parser p;
  p.set_debug_level (1);
  return p.parse();
}
