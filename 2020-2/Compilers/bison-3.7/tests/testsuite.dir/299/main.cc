/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>

// If we are compiling with CC=$CXX, then do not load the C headers
// inside extern "C", since they were _not_ compiled this way.
#if ! CC_IS_CXX
extern "C"
{
#endif
  #include "x1.h"
  #include "x2.h"
  #include "x3.h"
  #include "x4.h"
  #include "x6.h"
  #include "x7.h"
  #include "x8.h"
#if ! CC_IS_CXX
}
#endif
#include "x5.hh"
#include "x9.hh"

#define RUN(S)                                  \
  do {                                          \
    int res = S;                                \
    if (res)                                    \
      std::cerr << #S": " << res << '\n';       \
  } while (false)

int
main (void)
{
  RUN(x1_parse());
  RUN(x2_parse());
  RUN(x3_parse());
  RUN(x4_parse());
  x5_::parser p5;
  RUN(p5.parse());
  RUN(x6_parse());
  RUN(x7_parse());
  RUN(x8_parse());
  x9_::parser p9;
  RUN(p9.parse());
  return 0;
}
