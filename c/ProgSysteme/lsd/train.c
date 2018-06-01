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


/* Les villes */
#define A 0
#define B 1
#define C 2
#define D 3
#define couleur(param) printf("\033[%sm",param)

pthread_mutex_t mutAB;
pthread_mutex_t mutDB;
pthread_mutex_t mutBC;


/* Code des threads */
void* train_de_A_vers_C(void* arg);
void* train_de_D_vers_A(void* arg);
void attendre(double max);


/* Moniteur : gestion du chemin de fer  */
void utiliser_le_segment(int ville_depart, int ville_arrivee)
{
  if(ville_depart == 0 || ville_arrivee == 0)
    pthread_mutex_lock(&mutAB);
  else if(ville_arrivee == 2)
    pthread_mutex_lock(&mutBC);
  else if(ville_depart == 3)
    pthread_mutex_lock(&mutDB);
  else{
    switch (ville_arrivee) {
      case 0:
        pthread_mutex_lock(&mutAB);
      case 2:
        pthread_mutex_lock(&mutBC);
    }
  }
}

void liberer_le_segment(int ville_depart, int ville_arrivee)
{
  if(ville_depart == 0 || ville_arrivee == 0)
    pthread_mutex_unlock(&mutAB);
  else if(ville_arrivee == 2)
    pthread_mutex_unlock(&mutBC);
  else if(ville_depart == 3)
    pthread_mutex_unlock(&mutDB);
  else{
    switch (ville_arrivee) {
      case 0:
        pthread_mutex_unlock(&mutAB);
      case 2:
        pthread_mutex_unlock(&mutBC);
    }
  }
}


int main(int argc, char* argv[])
{
  /* Creer autant de trains que
  necessaire */
  int       i;
  pthread_t threads[5];
  pthread_mutex_init(&mutAB,NULL);
  pthread_mutex_init(&mutDB,NULL);
  pthread_mutex_init(&mutBC,NULL);

  pthread_create(&threads[0], NULL, train_de_A_vers_C, NULL);
  pthread_create(&threads[1], NULL, train_de_D_vers_A, NULL);
  pthread_create(&threads[2], NULL, train_de_A_vers_C, NULL);
  pthread_create(&threads[3], NULL, train_de_D_vers_A, NULL);
  pthread_create(&threads[4], NULL, train_de_D_vers_A, NULL);

  for (i = 0; i < 5; i++) {
    pthread_join(threads[i], NULL);
  }
}


void* train_de_A_vers_C(void* arg)
{
  int id = pthread_self();
	utiliser_le_segment(A, B);
  printf("Train ");
  couleur("33");
  printf("[%d]",id );
  couleur("0");
	printf(" : utilise segment AB \n");
	attendre(6);
	liberer_le_segment(A, B);

	utiliser_le_segment(B, C);
  printf("Train ");
  couleur("33");
  printf("[%d]",id );
  couleur("0");
	printf(" : utilise segment BC \n");
	attendre(6);
	liberer_le_segment(B, C);
  couleur("32");
  printf("Train ");
  couleur("33");
  printf("[%d]",id );
  couleur("32");
	printf(" : arrivé à destination \n");
  couleur("0");
	pthread_exit(NULL);
}

void* train_de_D_vers_A(void* arg)
{
  int id = pthread_self();
	utiliser_le_segment(D, B);
  printf("Train ");
  couleur("33");
  printf("[%d]",id );
  couleur("0");
	printf(" : utilise segment DB \n");
	attendre(5);
	liberer_le_segment(D, B);

	utiliser_le_segment(A, B);
  printf("Train ");
  couleur("33");
  printf("[%d]",id );
  couleur("0");
	printf(" : utilise segment BA \n");
	attendre(5);
	liberer_le_segment(A, B);
  couleur("32");
  printf("Train ");
  couleur("33");
  printf("[%d]",id );
  couleur("32");
	printf(" : arrivé à destination \n");
  couleur("0");
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
