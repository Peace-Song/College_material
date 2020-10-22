/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>

#include <iostream>
int main()
{
#if defined __cplusplus && 201103L <= __cplusplus
  std::cout << "Modern C++: " << __cplusplus << '\n';
  return 0;
#else
  std::cout << "Legac++\n";
  return 1;
#endif
}
