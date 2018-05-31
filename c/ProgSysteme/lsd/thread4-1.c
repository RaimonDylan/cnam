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

#define WAIT_TIME_SECONDS   3
pthread_mutex_t mut;
pthread_cond_t cond;
struct timespec   ts;
struct timeval    tp;
int cpt = 0;

void* th(void* arg){
  for (int i = 0; i < 4; i++) {
    cpt++;
  }
  printf("Fin du thread %d, valeur cpt = %d\n",pthread_self(),cpt);
  pthread_exit(NULL);
}

void* th1(void* arg){
  // 4 - 1 - a : la condition est deja rempli pendant le sleep
  for (int i = 0; i < 4; i++) {
    cpt++;
  }
  printf("Fin du thread %d, valeur cpt = %d\n",pthread_self(),cpt);
  pthread_exit(NULL);
}

void* th2(void* arg){
  pthread_mutex_lock(&mut);
  gettimeofday(&tp, NULL);
  ts.tv_sec  = tp.tv_sec;
  ts.tv_nsec = tp.tv_usec * 1000;
  ts.tv_sec += WAIT_TIME_SECONDS;
  //sleep(5);
  // 4 - 1 - b : si on supprime la condition le thread attend de manière infini
  while(pthread_cond_timedwait(&cond, &mut, &ts) != ETIMEDOUT){
  }
  //printf("Je suis le thread %d qu a attendu que cpt soit supérieur à 3, valeur cpt =%d\n",pthread_self(),cpt);
  printf("Je suis le thread %d qu a attendu le time out de la fonction timedwait, valeur cpt =%d\n",pthread_self(),cpt);
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
