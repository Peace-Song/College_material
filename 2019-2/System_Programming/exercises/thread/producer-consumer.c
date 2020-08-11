#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

#define NITERS 5

struct {
  int buf;
  sem_t full;
  sem_t empty;
} shared;

void *producer(void *vargp);
void *consumer(void *vargp);

int main(){
  pthread_t tid_producer;
  pthread_t tid_consumer;

  sem_init(&shared.empty, 0, 1);
  sem_init(&shared.full, 0, 0);

  pthread_create(&tid_producer, NULL, producer, NULL);
  pthread_create(&tid_consumer, NULL, consumer, NULL);
  
  pthread_join(tid_producer, NULL);
  pthread_join(tid_consumer, NULL);

  exit(0);
}

void *producer(void *vargp){
  int i, item;

  for(i = 0; i < NITERS; i++){
    item = i;
    printf("Producer produced %d.\n", item);
    
    sem_wait(&shared.empty);
    shared.buf = item;
    sem_post(&shared.full);
  }

  return NULL;
}

void *consumer(void *vargp){
  int i, item;

  for(i = 0; i < NITERS; i++){
    sem_wait(&shared.full);
    item = shared.buf;
    sem_post(&shared.empty);
    
    printf("Consumer consumed %d.\n", item);
  }
  
  return NULL;
}
