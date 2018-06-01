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

sem_t sem;
pthread_mutex_t mut;


/* Code des threads */
void* voiture(void* arg);
void* camion(void* arg);
void attendre(double max);

int main(int argc, char* argv[])
{
  int       i;
  pthread_t threads[5];
  sem_init(&sem,0,3);
  pthread_mutex_init(&mut,NULL);

  pthread_create(&threads[0], NULL, camion, NULL);
  pthread_create(&threads[1], NULL, voiture, NULL);
  pthread_create(&threads[2], NULL, camion, NULL);
  pthread_create(&threads[3], NULL, voiture, NULL);
  pthread_create(&threads[4], NULL, camion, NULL);

  for (i = 0; i < 5; i++) {
    pthread_join(threads[i], NULL);
  }
}

void onPont(int t){
  if(t==15){
    pthread_mutex_lock(&mut);
    sem_wait(&sem);
    sem_wait(&sem);
    sem_wait(&sem);
    pthread_mutex_unlock(&mut);
  }
  else
    sem_wait(&sem);
}

void offPont(int t){
  if(t==15){
    sem_post(&sem);
    sem_post(&sem);
    sem_post(&sem);
  }
  else
    sem_post(&sem);
}


void* voiture(void* arg)
{
  int id = pthread_self();
  onPont(5);
  printf("Voiture ");
  couleur("33");
  printf("[%d]",id );
  couleur("0");
	printf(" : passe sur le pont\n");
  attendre(5);
  couleur("32");
  printf("Voiture ");
  couleur("33");
  printf("[%d]",id );
  couleur("32");
	printf(" : a passé le pont\n");
  couleur("0");
  offPont(5);
	pthread_exit(NULL);
}

void* camion(void* arg)
{
  int id = pthread_self();
  onPont(15);
  printf("Camion  ");
  couleur("33");
  printf("[%d]",id );
  couleur("0");
	printf(" : passe sur le pont\n");
  attendre(8);
  couleur("32");
  printf("Camion  ");
  couleur("33");
  printf("[%d]",id );
  couleur("32");
	printf(" : a passé le pont\n");
  couleur("0");
  offPont(15);
	pthread_exit(NULL);
}





int tirage_aleatoire(double max)
{
        int j=(int) (max*rand()/(RAND_MAX+1.0));
        if(j<1)
                j=1;
        return j;
}



void attendre(double max)
{
        struct timespec delai;

        delai.tv_sec=tirage_aleatoire(max);
        delai.tv_nsec=0;
        nanosleep(&delai,NULL);
}
