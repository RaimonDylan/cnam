#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/sem.h>


pthread_mutex_t mut;
pthread_cond_t cond;
int x = 0;

void* th(void* arg){
  pthread_mutex_lock(&mut);
  while (x<1) {
    pthread_cond_wait(&cond, &mut);
  }
  printf("Fin du thread %d\n",pthread_self());
  pthread_mutex_unlock(&mut);
  pthread_exit(NULL);
}
int main(int argc, char* argv[]){
  pthread_t id1,id2,id3,id4;
  pthread_create(&id1,NULL,th,NULL);
  pthread_create(&id2,NULL,th,NULL);
  pthread_create(&id3,NULL,th,NULL);
  pthread_create(&id4,NULL,th,NULL);
  sleep(5);
  x=1;
  pthread_cond_signal(&cond);
  pthread_join(id1,NULL);
  pthread_join(id2,NULL);
  pthread_join(id3,NULL);
  pthread_join(id4,NULL);
  return 0;
}
