/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>

#include "calc.h"

#include <assert.h>
#include <unistd.h>



/* Value of the last computation.  */
semantic_value global_result = 0;
/* Total number of computations.  */
int global_count = 0;
/* Total number of errors.  */
int global_nerrs = 0;

/* A C main function.  */
int
main (int argc, const char **argv)
{
  semantic_value result = 0;
  int count = 0;
  int nerrs = 0;
  int status;

  /* This used to be alarm (10), but that isn't enough time for a July
     1995 vintage DEC Alphastation 200 4/100 system, according to
     Nelson H. F. Beebe.  100 seconds was enough for regular users,
     but the Hydra build farm, which is heavily loaded needs more.  */

  alarm (200);

  if (argc == 2)
    input = fopen (argv[1], "r");
  else
    input = stdin;

  if (!input)
    {
      perror (argv[1]);
      return 3;
    }

  calcdebug = 1;
  status = calcparse (&result, &count, &nerrs);
  if (fclose (input))
    perror ("fclose");
  assert (global_result == result); (void) result;
  assert (global_count  == count);  (void) count;
  assert (global_nerrs  == nerrs);  (void) nerrs;
  printf ("final: %d %d %d\n", global_result, global_count, global_nerrs);
  return status;
}
