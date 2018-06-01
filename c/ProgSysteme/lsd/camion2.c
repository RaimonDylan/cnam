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
#define CHARGE_MAX 15

sem_t sem;
sem_t sem2;
pthread_mutex_t mut;
int nbWaitCamion=0;
int nbWaitVoiture=0;
int charge=0;


/* Code des threads */
void* voiture(void* arg);
void* camion(void* arg);
void attendre(double max);

int main(int argc, char* argv[])
{
  int       i;
  pthread_t threads[10];
  sem_init(&sem,0,0);
  sem_init(&sem2,0,0);
  pthread_mutex_init(&mut,NULL);
  // GENERATION ALEATOIRE DE CAMION ET DE VOITURE
  for (int i = 0; i < 10; i++) {
    int nb=rand()%9;
    if(nb<5)
      pthread_create(&threads[i], NULL, voiture, NULL);
    else
      pthread_create(&threads[i], NULL, camion, NULL);
  }
  for (i = 0; i < 10; i++) {
    pthread_join(threads[i], NULL);
  }
}

void onPont(int t){
  pthread_mutex_lock(&mut);
  if(charge+t <= 15){
    charge = charge+t;
    if(t==5) sem_post(&sem);
    else sem_post(&sem2);
  }else{
    if(t==5) nbWaitVoiture++;
    else nbWaitCamion++;
  }
  pthread_mutex_unlock(&mut);
  if(t==5) sem_wait(&sem);
  else sem_wait(&sem2);
}

void offPont(int t){
  pthread_mutex_lock(&mut);
  charge = charge - t;
  if(nbWaitCamion>0 && charge ==0){
    nbWaitCamion--;
    sem_post(&sem2);
    charge=15;
  }else if(nbWaitCamion==0 && nbWaitVoiture>0 && charge<15){
    nbWaitVoiture--;
    sem_post(&sem);
    charge=charge+5;
  }
  pthread_mutex_unlock(&mut);
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
