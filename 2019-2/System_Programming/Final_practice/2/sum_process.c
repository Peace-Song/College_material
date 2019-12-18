//------------------------------------------------------------------------------
/// @file  sum_process.c
/// @brief sample solution to practice problem 2 using processes and pipes
///
/// @author Bernhard Egger <bernhard@csap.snu.ac.kr>
/// @section changelog Change Log
/// - 2019/12/03 Bernhard Egger created
///
/// @section license_section License
/// Copyright (c) 2019, Computer Systems and Platforms Laboratory, SNU
/// All rights reserved.
///
/// Redistribution and use in source and binary forms,  with or without modifi-
/// cation, are permitted provided that the following conditions are met:
///
/// - Redistributions of source code must retain the above copyright notice,
///   this list of conditions and the following disclaimer.
/// - Redistributions in binary form must reproduce the above copyright notice,
///   this list of conditions and the following disclaimer in the documentation
///   and/or other materials provided with the distribution.
///
/// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
/// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,  BUT NOT LIMITED TO,  THE
/// IMPLIED WARRANTIES OF MERCHANTABILITY  AND FITNESS FOR A PARTICULAR PURPOSE
/// ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER  OR CONTRIBUTORS BE
/// LIABLE FOR ANY DIRECT,  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSE-
/// QUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF  SUBSTITUTE
/// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
/// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT
/// LIABILITY, OR TORT  (INCLUDING NEGLIGENCE OR OTHERWISE)  ARISING IN ANY WAY
/// OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
/// DAMAGE.
//------------------------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <limits.h>
#include <pthread.h>        // do not forget to compile with -pthread
#include <semaphore.h>

#define WRITE 1             // write end of pipe
#define READ 0              // read end of pipe


// global sum
int sum = 0;




void* process_main(int pipe[2], int iter)
{
  // close read end of pipe
  close(pipe[READ]);

  fprintf(stdout, "Process %d counting to %d.\n", getpid(), iter);

  for (int i=0; i<iter; i++) {
    // no need to protect sum - processes run in separate address spaces
    sum++;
  }

  // write result into pipe. We write the four bytes of the integer directly
  // into the pipe without first converting it to a string
  write(pipe[WRITE], &sum, sizeof(sum));

  // close write end. When all writers have closed their write end, the read()
  // call in the parent will return EOF.
  close(pipe[WRITE]);

  exit(EXIT_SUCCESS);
}


int main(int argc, char *argv[])
{
  // check that argument was provided
  if (argc != 2) {
    fprintf(stderr, "Syntax: %s <N> where N is the number of processes/threads"
                    " to be created.\n", argv[0]);
    return EXIT_FAILURE;
  }

  // convert to integer (similar to atoi() but allows for better error checks)
  // see man strtol for details.
  int N;
  char *endptr;

  errno = 0;
  N = strtol(argv[1], &endptr, 0);

  if (((errno == ERANGE) && (N == LONG_MAX || N == LONG_MIN)) ||
      ((errno != 0) && (N == 0)))
  {
    perror("Invalid number");
    return EXIT_FAILURE;
  }
  if (endptr == argv[1]) {
    fprintf(stderr, "No digits found.\n");
    return EXIT_FAILURE;
  }

  // create the "work" by randomly assigning how many "work items" each
  // process should process.
  // At the same time, we count the total number of "work items" - at the end
  // this number should be equal to the global variable sum.
  int work[N];
  int ctrl_sum = 0;
  for (int i=0; i<N; i++) {
    work[i] = rand() % (1 << 16);       // number of "work items" for process i
    ctrl_sum += work[i];
  }

  // create a pipe that is used as an information transport from the forked
  // children to the parent.
  int pfd[2];
  if (pipe(pfd) < 0) {
    perror("Cannot create pipe");
    return EXIT_FAILURE;
  }

  // create N processes that each will run process_main(). The amount of work is
  // passed as an argument to the process.
  // The processes return the result by writing it into the write end of a pipe
  // that is connected to the parent.
  pid_t pid;

  for (int i=0; i<N; i++) {
    if ((pid = fork()) < 0) {
      perror("Cannot fork");
      return EXIT_FAILURE;
    } else if (pid == 0) {
      process_main(pfd, work[i]);
    }
  }

  // close parent's write end
  close(pfd[WRITE]);

  // read from pipe until we get an EOF - this will happen when all writers
  // (i.e., children) have exited
  int val;
  ssize_t res;
  while (1) {
    // restart read() systemcall if interrupted
    while ((res = read(pfd[READ], &val, sizeof(val))) < 0) {
      if (errno != EINTR) {
        perror("Cannot read from pipe");
        return EXIT_FAILURE;
      }
    }

    // end of file? (no data & no more writers -> all children have exited)
    if (res == 0) break;

    // check that we got a full value and no shortcount
    if (res != sizeof(val)) {
      fprintf(stderr, "Unable to read full integer.\n");
      return EXIT_FAILURE;
    }

    // add value red from pipe to sum
    sum += val;
  }

  // close read end
  close(pfd[READ]);

  // print result & compare to ctrl_sum
  printf("Total sum is %d.\n", sum);
  if (ctrl_sum == sum) printf("Good!\n");
  else printf("Hmm...expected %d.\n", ctrl_sum);

  return EXIT_SUCCESS;
}
