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

void* th(void* arg){
  printf("Je suis le thread %d ; processus %d\n",pthread_self(),getpid());
  pthread_exit(NULL);
}
int main(int argc, char* argv[]){
  int nbP = 10, status;
  for (int i = 0; i < nbP; i++) {
    pthread_t i;
    pthread_create(&i,NULL,th,NULL);
  }
  return 0;
}
