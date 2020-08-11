#include <stdio.h>
#include <pthread.h>

volatile int cnt = 0;

void *thread_cb(void *vargp);

int main(int argc, char **argv){
  if(argc != 2){
    printf("Wrong argument!\n");
    printf("Usage: ./thread_count <niters>\n");
    exit(1);
  }

  int niters = atoi(argv[1]);
  pthread_t tid1, tid2;

  pthread_create(&tid1, NULL, thread_cb, &niters);
  pthread_create(&tid2, NULL, thread_cb, &niters);

  pthread_join(tid1, NULL);
  pthread_join(tid2, NULL);

  if(cnt != 2 * niters)
    printf("KABOOM! cnt=%d and niters=%d\n", cnt, niters);
  else
    printf("OK! cnt=%d and niters=%d\n", cnt, niters);
  
  exit(0);
}

void *thread_cb(void *vargp){
  int i, niters = *((int *)vargp);
  for(i = 0; i < niters; i++){
    cnt++;
  }
  
  return NULL;
}
