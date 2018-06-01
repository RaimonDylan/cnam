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
#include <semaphore.h>

#define couleur(param) printf("\033[%sm",param)
int a = 0;
int b = 0;
int fibo(int n);
void* fibo2(void* arg);
int main(int argc, char* argv[])
{
  pthread_t thread;
  couleur("33");
  printf("La suite de Fibonacci :\n");
  couleur("32");
  for (int i = 0; i < 30; i++) {
    int* r;
    pthread_create(&thread, NULL, fibo2, &i);
    pthread_join(thread, (void **)&r);
    printf("%d, ",*r);
    free(r);
  }
  printf("\n");
  couleur("0");
  pthread_exit(NULL);
}


int fibo(int n){
  if(n == 0) return 0;
  else if (n == 1) return 1;
  else return fibo(n-2)+fibo(n-1);
}

// Multithread

void* fibo2(void* arg){
  int i = ((int*)arg)[0];
  if(i==0){
    int *valret;
    valret = (int*)malloc(sizeof(int));
    *valret=0;
    pthread_exit((void *)valret);
  }
  else if(i==1){
    int *valret;
    valret = (int*)malloc(sizeof(int));
    *valret=1;
    pthread_exit((void *)valret);
  }
  else{
    pthread_t id1,id2;
    int *valret;
    int* r1;
    int* r2;
    a = i-2;
    b = i-1;
    pthread_create(&id1, NULL, fibo2, &a);
    pthread_create(&id2, NULL, fibo2, &b);
    pthread_join(id1, (void **)&r1);
    pthread_join(id2, (void **)&r2);
    valret = (int*)malloc(sizeof(int));
    *valret=*r1+*r2;
    free(r1);
    free(r2);
    pthread_exit((void *)valret);
  }
}
