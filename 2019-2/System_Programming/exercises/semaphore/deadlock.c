#include <stdio.h>
#include <semaphore.h>
#include <pthread.h>

#define NITERS 5

sem_t mutex[2];
int cnt = 0;

void *count(void *vargp);

int main(){
  pthread_t tid[2];
  
  sem_init(&mutex[0], 0, 1);
  sem_init(&mutex[1], 0, 1);

  pthread_create(&tid[0], NULL, count, (void *) 0);
  pthread_create(&tid[1], NULL, count, (void *) 1);

  pthread_join(tid[0], NULL);
  pthread_join(tid[1], NULL);
  
  printf("cnt = %d\n", cnt);
  exit(0);
}

void *count(void *vargp){
  int i;
  int id = (int)vargp;
  for(i = 0; i < NITERS; i++){
    sem_wait(&mutex[id]);
    sem_wait(&mutex[1-id]);
    cnt++;
    sem_post(&mutex[id]);
    sem_post(&mutex[1-id]);
  }

  return NULL;
}
