%code top { /* -*- c++ -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%skeleton "lalr1.cc"
%define api.value.type variant
%define parse.assert
%debug

%code provides
{
  static int yylex (yy::parser::semantic_type *lvalp);
}

%token <int> INT "int"
%type <std::vector<int>> exp

%printer { yyo << $$; } <int>
%printer
  {
    for (std::vector<int>::const_iterator i = $$.begin (); i != $$.end (); ++i)
      {
        if (i != $$.begin ())
          yyo << ", ";
        yyo << *i;
      }
  } <std::vector<int>>

%code requires { #include <vector> }
%code { int yylex (yy::parser::semantic_type* lvalp); }

// A hack which relies on internal hooks to check stack_symbol_type,
// which is private.
%code yy_bison_internal_hook {
  public:
    typedef stack_symbol_type yy_stack_symbol_type;
    typedef stack_type yy_stack_type;
}

%%
exp: "int" { $$.push_back ($1); }
%%
/* A C++ error reporting function.  */
void
yy::parser::error (const std::string& m)
{
  std::cerr << m << '\n';
}
#include <assert.h>
static
int yylex (yy::parser::semantic_type *lvalp)
{
  static char const input[] = "";
  static int toknum = 0;
  int res;
  (void) lvalp;
  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  ;

  return res;
}

template <typename Exp, typename Eff>
void assert_eq (const Exp& exp, const Eff& eff)
{
  if (getenv ("DEBUG"))
    std::cerr << "Assert: " << exp << " == " << eff << '\n';
  if (exp != eff)
    std::cerr << "Assertion failed: " << exp << " != " << eff << '\n';
}

int main()
{
  using yy::parser;
  // symbol_type: construction, accessor.
  {
    parser::symbol_type s = parser::make_INT (12);
    assert_eq (s.kind (), parser::symbol_kind::S_INT);
    assert_eq (parser::symbol_name (s.kind ()), std::string ("\"int\""));
    assert_eq (s.name (), std::string ("\"int\""));
    assert_eq (s.value.as<int> (), 12);
  }

  // symbol_type: move constructor.
#if 201103L <= YY_CPLUSPLUS
  {
    auto s = parser::make_INT (42);
    auto s2 = std::move (s);
    assert_eq (s2.value.as<int> (), 42);
    // Used to crash here, because s was improperly cleared, and
    // its destructor tried to delete its (moved) value.
  }
#endif

  // symbol_type: copy constructor.
  {
    parser::symbol_type s = parser::make_INT (51);
    parser::symbol_type s2 = s;
    assert_eq (s.value.as<int> (), 51);
    assert_eq (s2.value.as<int> (), 51);
  }

  // stack_symbol_type: construction, accessor.
  typedef parser::yy_stack_symbol_type stack_symbol_type;
  {
#if 201103L <= YY_CPLUSPLUS
    auto ss = stack_symbol_type (1, parser::make_INT(123));
#else
    parser::symbol_type s = parser::make_INT (123);
    stack_symbol_type ss(1, s);
#endif
    assert_eq (ss.value.as<int> (), 123);
  }

  // Pushing on the stack.
  // Sufficiently many so that it will be resized.
  // Probably 3 times (starting at 200).
  {
    parser::yy_stack_type st;
    const int mucho = 1700;
    const int int_reduction_state = 1; // Read list.output to find it.
    for (int i = 0; i < mucho; ++i)
      {
#if 201103L <= YY_CPLUSPLUS
        st.push(stack_symbol_type{int_reduction_state,
                                  parser::make_INT (i)});
#else
        parser::symbol_type s = parser::make_INT (i);
        stack_symbol_type ss (int_reduction_state, s);
        st.push (ss);
#endif
      }
    for (int i = mucho - 1; 0 <= i; --i)
      {
        assert_eq (st[0].value.as<int>(), i);
        st.pop ();
      }
  }
}
