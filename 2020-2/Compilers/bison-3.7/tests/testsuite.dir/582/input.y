%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%code {
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);

  /* This prevents this test case from having to induce error messages
     large enough to overflow size_t.  */
  #define YYSIZE_T unsigned char

  /* Bring in malloc and set EXIT_SUCCESS so yacc.c doesn't try to
     provide a malloc prototype using our YYSIZE_T.  */
  #include <stdlib.h>
  #ifndef EXIT_SUCCESS
  # define EXIT_SUCCESS 0
  #endif

  /* Max depth is usually much smaller than YYSTACK_ALLOC_MAXIMUM, and
     we don't want gcc to warn everywhere this constant would be too big
     to make sense for our YYSIZE_T.  */
  #define YYMAXDEPTH 100
}

%define parse.error verbose

%%

start: syntax_error1 check syntax_error2 check syntax_error3;

// Induce a syntax error message whose total length causes yymsg in
// yyparse to be reallocated to size YYSTACK_ALLOC_MAXIMUM, which
// should be 255.  Each token here is 64 bytes.
syntax_error1:
  "123456789112345678921234567893123456789412345678951234567896123A"
| "123456789112345678921234567893123456789412345678951234567896123B"
| "123456789112345678921234567893123456789412345678951234567896123C"
| error 'a' 'b' 'c'
;

check:
{
  if (yymsg_alloc != YYSTACK_ALLOC_MAXIMUM
      || YYSTACK_ALLOC_MAXIMUM != YYSIZE_MAXIMUM
      || YYSIZE_MAXIMUM != 255)
    {
      fprintf (stderr,
               "The assumptions of this test group are no longer\n"
               "valid, so it may no longer catch the error it was\n"
               "designed to catch.  Specifically, the following\n"
               "values should all be 255:\n\n");
      fprintf (stderr, "  yymsg_alloc = %d\n", yymsg_alloc);
      fprintf (stderr, "  YYSTACK_ALLOC_MAXIMUM = %d\n",
               YYSTACK_ALLOC_MAXIMUM);
      fprintf (stderr, "  YYSIZE_MAXIMUM = %d\n", YYSIZE_MAXIMUM);
      YYABORT;
    }
}
;

// We used to overflow memory here because the first four "expected"
// tokens plus rest of the error message is greater that 255 bytes.
// However there are *five* expected tokens here, so anyway we will
// *not* display these tokens.  So the message fits, no overflow.
syntax_error2:
  "123456789112345678921234567893123456789412345678951234567896123A"
| "123456789112345678921234567893123456789412345678951234567896123B"
| "123456789112345678921234567893123456789412345678951234567896123C"
| "123456789112345678921234567893123456789412345678951234567896123D"
| "123456789112345678921234567893123456789412345678951234567896123E"
| error 'd' 'e' 'f'
;


// Now overflow.
syntax_error3:
  "123456789112345678921234567893123456789412345678951234567896123A"
| "123456789112345678921234567893123456789412345678951234567896123B"
| "123456789112345678921234567893123456789412345678951234567896123C"
| "123456789112345678921234567893123456789412345678951234567896123D"
;

%%





/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
  /* Induce two syntax error messages (which requires full error
     recovery by shifting 3 tokens).  */
#include <assert.h>
static
int yylex (void)
{
  static char const input[] = "abcdef";
  static int toknum = 0;
  int res;

  enum { input_elts = sizeof input / sizeof input[0] };
  (void) input_elts;
  assert (0 <= toknum && toknum < input_elts);
  res = input[toknum++];
  ;

  return res;
}
int
main (void)
{
  /* Push parsers throw away the message buffer between tokens, so skip
     this test under maintainer-push-check.  */
  if (YYPUSH)
    return 77;
  return yyparse ();
}
