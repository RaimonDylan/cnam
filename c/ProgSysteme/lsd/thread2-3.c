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
  sleep(2);
  printf("Je suis le thread %d\n",pthread_self(),getpid());
  pthread_exit(NULL);
}
int main(int argc, char* argv[]){
    pthread_t id;
    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr,PTHREAD_CREATE_DETACHED);
    pthread_create(&id,&attr,th,NULL);
    pthread_join(id,NULL);
    // Le thread principal n'attend pas le fils car il n'est pas joignable
    printf("Fin du thread principal, après la mort du fils : %d\n", id);
  return 0;
}
