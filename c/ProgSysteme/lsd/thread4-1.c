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
#include <time.h>
#include <sys/time.h>
#include <errno.h>

pthread_mutex_t mut;
pthread_cond_t cond;
struct timespec tim;
int cpt = 0;

void* th(void* arg){
  for (int i = 0; i < 4; i++) {
    cpt++;
  }
  printf("Fin du thread %d, valeur cpt = %d\n",pthread_self(),cpt);
  pthread_exit(NULL);
}

void* th1(void* arg){
  sleep(5);
  // 4 - 1 - a : la condition est deja rempli pendant le sleep
  for (int i = 0; i < 4; i++) {
    cpt++;
  }
  printf("Fin du thread %d, valeur cpt = %d\n",pthread_self(),cpt);
  pthread_exit(NULL);
}

void* th2(void* arg){
  pthread_mutex_lock(&mut);
  //sleep(5);
  // 4 - 1 - b : si on supprime la condition le thread attend de manière infini
  while(cpt<3){
    pthread_cond_timedwait(&cond,&mut,&tim);
  }
  printf("Je suis le thread %d qu a attendu que cpt soit supérieur à 3, valeur cpt =%d\n",pthread_self(),cpt);
  pthread_mutex_unlock(&mut);
  pthread_exit(NULL);
}


int main(int argc, char* argv[]){
  pthread_t id1,id2,id3;
  pthread_mutex_lock(&mut);
  pthread_create(&id1,NULL,th,NULL);
  pthread_create(&id2,NULL,th1,NULL);
  pthread_create(&id3,NULL,th2,NULL);
  pthread_mutex_unlock(&mut);
  pthread_join(id1,NULL);
  pthread_join(id2,NULL);
  pthread_join(id3,NULL);
  return 0;
}
