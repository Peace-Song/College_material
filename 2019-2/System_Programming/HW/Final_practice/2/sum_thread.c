//------------------------------------------------------------------------------
/// @file  sum_thread.c
/// @brief sample solution to practice problem 2 using threads
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

// global sum
int sum = 0;

// semaphore
sem_t mutex;

#define PROTECT 0           // set to 1 to protect 'sum'
                            // set to 0 to trigger races on sum
                            // try both and see what happens

void* thread_main(void *arg)
{
  int iter = *((int*)arg);

  fprintf(stdout, "Thread %lu counting to %d.\n", pthread_self(), iter);

  for (int i=0; i<iter; i++) {
    if (PROTECT && (sem_wait(&mutex) < 0)) {
      fprintf(stderr, "Cannot wait on semaphore! Aborting thread.\n");
      pthread_exit(NULL);
    }

    sum++;

    if (PROTECT && (sem_post(&mutex) < 0)) {
      fprintf(stderr, "Cannot wait on semaphore! Aborting thread.\n");
      pthread_exit(NULL);
    }
  }

  return NULL;
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
  // thread should process.
  // At the same time, we count the total number of "work items" - at the end
  // this number should be equal to the global variable sum.
  int work[N];
  int ctrl_sum = 0;
  for (int i=0; i<N; i++) {
    work[i] = rand() % (1 << 16);       // number of "work items" for thread i
    ctrl_sum += work[i];
  }

  // initialize semaphore 'mutex' used to protect the global shared 'sum'
  if (sem_init(&mutex, 0, 1) < 0) {
    perror("Cannot initialize semaphore");
    return EXIT_FAILURE;
  }

  // create N threads that each will run thread_main(). The amount of work is
  // passed as an argument to the thread.
  // We create joinable threads since we want to make sure all threads
  // have terminated before printing the end result
  pthread_t tid[N];

  for (int i=0; i<N; i++) {
    if (pthread_create(&tid[i], NULL, thread_main, &work[i]) != 0) {
      fprintf(stderr, "Cannot create thread.\n");
      return EXIT_FAILURE;
    }
  }

  // wait for all threads to terminate
  for (int i=0; i<N; i++) {
    if (pthread_join(tid[i], NULL) != 0) {
      fprintf(stderr, "Cannot join thread.\n");
      return EXIT_FAILURE;
    }
  }

  // print result & compare to ctrl_sum
  printf("Total sum is %d.\n", sum);
  if (ctrl_sum == sum) printf("Good!\n");
  else printf("Hmm...expected %d.\n", ctrl_sum);

  return EXIT_SUCCESS;
}
