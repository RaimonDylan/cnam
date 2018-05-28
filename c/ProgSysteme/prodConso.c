#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/sem.h>
#include <sys/wait.h>

#define couleur(param) printf("\033[%sm",param)
#define MAX 50


int P(int semid, int ns){
  struct sembuf oper;
  oper.sem_num = ns; oper.sem_op = -1; oper.sem_flg=0;
  if(semop(semid,&oper,1)==-1){
    perror("\nImpossible de decrementer le sémaphore");
    exit(3);
  }
}

int V(int semid, int ns){
  struct sembuf oper;
  oper.sem_num = ns; oper.sem_op = 1; oper.sem_flg=0;
  if(semop(semid,&oper,1)==-1){
    perror("\nImpossible de d'incrementer le sémaphore");
    exit(4);
  }
}

int main(int argc,char *argv[]){
  int semid,semid2,i,status; pid_t retour;
  int alter = 0;
  int potion =0;
  int stock = 0;
  sigset_t ens1;
  sigemptyset(&ens1);sigaddset(&ens1,SIGINT);sigaddset(&ens1,SIGQUIT);sigaddset(&ens1,SIGUSR1);
  sigprocmask(SIG_SETMASK,&ens1,NULL);
  if((semid =semget(IPC_PRIVATE,2,IPC_CREAT|IPC_EXCL|0600))==-1){
    perror("\nerreur création de sémaphore");
    exit(1);
  }

  semctl(semid,0,SETVAL,0);
  semctl(semid,1,SETVAL,10);
  for (int i = 1; i <= 2; i++) {
    if ((retour = fork())==-1) {
      perror("\nEchec de fork");
      exit(2);
    }
    if(retour==0){
      switch (i) {
        case 1:
          while(1){
            couleur("32");
            printf("> Producteur start \n");
            sleep(2);
            P(semid,1);
            V(semid,0);
            couleur("33");
            printf("STOCK :\n");
            printf("  ");
            for (int i = 0; i < semctl(semid,0,GETVAL,0); i++) {
              if(i%2 == 1)printf("\n  ");
              printf("[]");
            }
            couleur("31");
            printf("\n> Producteur stop\n");
          }
        case 2:
          while(1){
            P(semid,0);
            V(semid,1);
            couleur("32");
            printf("> Consommateur start\n");
            sleep(1);
            couleur("31");
            printf("> Consommateur stop\n");
          }
      }
    }
  }
  for (int i = 1; i <= 2; i++) {
    wait(&status);
  }
  semctl(semid,0,IPC_RMID);
  semctl(semid,1,IPC_RMID);
  sigprocmask(SIG_SETMASK,&ens1,NULL);
  exit(0);
}
