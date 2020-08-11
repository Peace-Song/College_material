#include <stdio.h>
#include <pthread.h>
#include <limits.h>

void *thread_cb(void *vargp);

int load_per_thread;

int main(){
  int num_threads;
  pthread_t tid;

  printf("Listing prime numbers using threads.\n");
  printf("Input the number of threads: "); 
  scanf("%d", &num_threads);
  printf("Maximum value of unsigned int in 64-bit system is: %u\n", UINT_MAX);
  
  load_per_thread = 5000 / num_threads;

  for(int i = 0; i < num_threads; i++){
    pthread_create(&tid, NULL, thread_cb, (void *)(load_per_thread * i));
    printf("Thread w/ tid=%ld has been created.\n", tid);
  }

  pthread_exit(NULL);
}

void *thread_cb(void *vargp){
  unsigned int start_int = (int)vargp;
  unsigned int dividend, divisor;

  if(start_int == 0) start_int = 2;

  for(dividend = start_int; dividend < start_int + load_per_thread; dividend++){
    printf("Thread w/ tid=%ld has started processing number %d!\n", pthread_self(), dividend);
    for(divisor = 2; divisor <= dividend; divisor++)
      if(dividend % divisor == 0 && dividend != divisor) break;
    
    if(divisor == dividend)
      printf("Thread w/ tid=%ld has decided that %d is a prime number!\n", pthread_self(), dividend);

    if(dividend == UINT_MAX) break;
  }

  return NULL;
}
