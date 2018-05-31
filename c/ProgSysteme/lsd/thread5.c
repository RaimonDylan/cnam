#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/sem.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <time.h>
#include <errno.h>

#define couleur(param) printf("\033[%sm",param)
int cpt;
int cpt2;
void handler(int sig,siginfo_t *sip, void*uap){
  cpt++;
  //printf("%d\n",cpt);
}
int main(int argc,char *argv[]){
  int status; pid_t retour;
  sigset_t ens1,ens2;
  struct sigaction sig;
  union sigval val;
  sig.sa_flags=SA_SIGINFO;
  sig.sa_sigaction=handler;
  sigemptyset(&sig.sa_mask);
  if(sigaction(SIGUSR1,&sig,NULL)<0)
    perror("sigaction");
  if ((retour = fork())==-1) {
    perror("\nEchec de fork");
    exit(2);
  }
  if(retour==0){
    clock_t before = clock();
    int trigger = 10000;
    int msec = 0;
    do {
      clock_t difference = clock() - before;
      msec = difference * 1000 / CLOCKS_PER_SEC;
    } while ( msec < trigger );
    couleur("32");
    printf("Nombre de signaux");
    couleur("33");
    printf(" [%d] ", cpt);
    couleur("32");
    printf("SIGUSR1 reçu par le processus FILS \n");
  }else{
    //struct timespec delai;
    //delai.tv_sec=1;
    //delai.tv_nsec=0;
    //val.sival_int=i;

    //nanosleep(&delai,NULL);
    clock_t before = clock();
    int trigger = 10000;
    int msec = 0;
    do {
      sigqueue(retour,SIGUSR1,val);
      cpt2++;
      clock_t difference = clock() - before;
      msec = difference * 1000 / CLOCKS_PER_SEC;
    } while ( msec < trigger );
    wait(&status);
    couleur("32");
    printf("Nombre de signaux");
    couleur("33");
    printf(" [%d] ", cpt2);
    couleur("32");
    printf("SIGUSR1 envoyé par le processus PERE \n");
  }
 couleur("0");
  exit(0);
}
