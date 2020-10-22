%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%debug
%define api.value.type variant
%skeleton "lalr1.cc" %define parse.assert %define api.token.constructor

%code top // code for the .cc file.
{
#include <cstdlib> // abort, getenv
#include <iostream>
#include <vector>
#include <sstream>
#include <string>

  class string
  {
    public:
      string () {}

      string (const std::string& s)
        : val_(s)
      {}

      string (const string& s)
        : val_(s.val_)
      {}

      string& operator= (const string& s)
      {
        val_ = s.val_;
        return *this;
      }

#if defined __cplusplus && 201103L <= __cplusplus
      string (string&& s) noexcept
        : val_(std::move(s.val_))
      {
        s.val_.clear();
      }

      string& operator= (string&& s)
      {
        val_ = std::move(s.val_);
        s.val_.clear ();
        return *this;
      }
#endif

      friend
      std::ostream& operator<< (std::ostream& o, const string& s)
      {
        return o << s.val_;
      }

    private:
      std::string val_;
  };

  typedef std::vector<string> strings_type;

  namespace yy
  {
    // Must be available early, as is used in %destructor.
    std::ostream&
    operator<<(std::ostream& o, const strings_type& s)
    {
      o << '(';
      for (strings_type::const_iterator i = s.begin (); i != s.end (); ++i)
        {
          if (i != s.begin ())
            o << ", ";
          o << *i;
        }
      return o << ')';
    }
  }
}

%code // code for the .cc file.
{
  namespace yy
  {
    static
    yy::parser::symbol_type yylex ();

    // Conversion to string.
    template <typename T>
      inline
      string
      to_string (const T& t)
    {
      std::ostringstream o;
      o << t;
      return string (o.str ());
    }
  }
}

%token <::string> TEXT;
%token <int> NUMBER;
%token END_OF_FILE 0;
%token COMMA ","

// Starting with :: to ensure we don't output "<::" which starts by the
// digraph for the left square bracket.
%type <::string> item;
// Using the template type to exercise its parsing.
%type <::std::vector<string>> list;

%printer { yyo << $$; } <int> <::string> <::std::vector<string>>;
%destructor { std::cerr << "Destroy: " << $$ << '\n'; } <*>;
%destructor { std::cerr << "Destroy: \"" << $$ << "\"\n"; } <::string>;
%%

result:
  list          { std::cout << $1 << '\n'; }
;

list:
  item          { $$.push_back ($1); }
| list "," item { $$ = $1; $$.push_back ($3); }
| list error    { $$ = $1; }
;

item:
  TEXT          { $$ = $1; }
| NUMBER        { int v = $1; if (v == 3) YYERROR; else $$ = to_string (v); }
;
%%

#define STAGE_MAX 5
namespace yy
{
  static
  yy::parser::symbol_type yylex ()
  {
    // The 5 is a syntax error whose recovery requires that we discard
    // the lookahead.  This tests a regression, see
    // <http://savannah.gnu.org/support/?108481>.
    static char const *input = "0,1,2,3,45,6";
    switch (int stage = *input++)
    {
      case 0:
        return parser::make_END_OF_FILE ();

      case ',':
        return parser::make_COMMA ();

      default:
        stage = stage - '0';
        if (stage % 2)
         {
           return parser::make_NUMBER (stage);
         }
       else
         {
           return parser::make_TEXT (to_string (stage));
         }
    }
  }
}

/* A C++ error reporting function.  */
void
yy::parser::error (const std::string& m)
{
  std::cerr << m << '\n';
}
#include <cstdlib> // getenv.
#include <cstring> // strcmp.
int
main (int argc, char const* argv[])
{
  yy::parser p;
  int debug = !!getenv ("YYDEBUG");
  for (int i = 1; i < argc; ++i)
    if (!strcmp (argv[i], "-p")
        || !strcmp (argv[i], "-d") || !strcmp (argv[i], "--debug"))
      debug |= 1;
    else if (!strcmp (argv[i], "-s") || !strcmp (argv[i], "--stat"))
      debug |= 2;
  p.set_debug_level (debug);
  return p.parse ();
}
