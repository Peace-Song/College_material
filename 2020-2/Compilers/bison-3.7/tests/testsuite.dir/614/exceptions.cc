/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>

#include <iostream>
#include <stdexcept>

void foo ()
{
  try
    {
      throw std::runtime_error ("foo");
    }
  catch (...)
    {
      std::cerr << "Inner caught\n";
      throw;
    }
}

int main ()
{
  try
    {
      foo ();
    }
  catch (...)
    {
      std::cerr << "Outer caught\n";
      return 0;
    }
  return 1;
}
