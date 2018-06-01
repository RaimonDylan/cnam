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
int entier10;
pthread_mutex_t mut;
char* res;
char* valeur;


void* convertir(void* arg);

int main(int argc, char* argv[])
{
  pthread_mutex_init(&mut,NULL);
  couleur("0");
  printf("Entrer un entier en base ");
  couleur("33");
  printf("[10]");
  couleur("0");
  printf(" : ");
  couleur("32");
  scanf("%d", &entier10);
  couleur("0");
  printf("Convertion en base ");
  couleur("33");
  printf("[2]");
  couleur("0");
  printf("        : ");
  couleur("32");
  pthread_t threads[8];
  for (int i = 0; i < 8; i++) {
      pthread_create(&threads[i], NULL, convertir, NULL);
  }
  for (int i = 0; i < 8; i++) {
    pthread_join(threads[i], NULL);
  }
  printf("%s", res);
  printf("\n");
  couleur("0");
}


void* convertir(void* arg)
{
  pthread_mutex_lock(&mut);
  int id = pthread_self();
  if(entier10>0){
    valeur = (char)entier10%2;
    res = strcat(res,valeur);
    entier10 = entier10/2;
  }
  pthread_mutex_unlock(&mut);
	pthread_exit(NULL);
}
