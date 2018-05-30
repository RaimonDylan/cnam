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

void* th(void* arg){
  pthread_mutex_lock(&mut);
  printf("Je suis le thread %d\n",pthread_self(),getpid());
  sleep(3);
  pthread_mutex_unlock(&mut);
  pthread_exit(NULL);
}
int main(int argc, char* argv[]){
  pthread_t id1,id2,id3;
  pthread_mutex_lock(&mut);
  pthread_create(&id1,NULL,th,NULL);
  pthread_create(&id2,NULL,th,NULL);
  pthread_create(&id3,NULL,th,NULL);
  sleep(3);
  pthread_mutex_unlock(&mut);
  pthread_join(id1,NULL);
  pthread_join(id2,NULL);
  pthread_join(id3,NULL);
  return 0;
}
