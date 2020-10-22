%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%code {#include <sstream>}
%locations
%debug
%skeleton "lalr1.cc"
%code
{

static int yylex (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp);
}
%%
exp: %empty;
%%
/* A C++ error reporting function.  */
void
yy::parser::error (const location_type& l, const std::string& m)
{
  std::cerr << l << ": " << m << '\n';
}
#include <assert.h>
static
int yylex (yy::parser::semantic_type *lvalp, yy::parser::location_type *llocp)
{
  static char const input[] = "";
  static int toknum = 0;
  int res;
  (void) lvalp;(void) llocp;
  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  ;

  (*llocp).begin.line = (*llocp).end.line = 1;
  (*llocp).begin.column = (*llocp).end.column = toknum;
  return res;
}

template <typename T>
bool
check (const T& in, const std::string& s)
{
  const static bool verbose = getenv ("DEBUG");
  std::stringstream os;
  os << in;
  if (os.str () == s)
    {
      if (verbose)
        std::cerr << os.str () << '\n';
      return true;
    }
  else
    {
      std::cerr << "fail: " << os.str () << ", expected: " << s << '\n';
      return false;
    }
}

int
main (void)
{
  const std::string fn = "foo.txt";
  int fail = 0;
  yy::parser::location_type loc (&fn);  fail += check (loc, "foo.txt:1.1");
                           fail += check (loc + 10, "foo.txt:1.1-10");
  loc += 10;               fail += check (loc, "foo.txt:1.1-10");
  loc += -5;               fail += check (loc, "foo.txt:1.1-5");
                           fail += check (loc - 5, "foo.txt:1.1");
  loc -= 5;                fail += check (loc, "foo.txt:1.1");
  // Check that we don't go below.
  // http://lists.gnu.org/archive/html/bug-bison/2013-02/msg00000.html
  loc -= 10;         fail += check (loc, "foo.txt:1.1");

  loc.columns (10); loc.lines (10); fail += check (loc, "foo.txt:1.1-11.0");
  loc.lines (-2);                   fail += check (loc, "foo.txt:1.1-9.0");
  loc.lines (-10);                  fail += check (loc, "foo.txt:1.1");

  yy::parser::location_type loc2 (YY_NULLPTR, 5, 10);
                   fail += check (loc2, "5.10");
                   fail += check (loc + loc2, "foo.txt:1.1-5.9");
  loc += loc2;     fail += check (loc, "foo.txt:1.1-5.9");
  return !fail;
}
