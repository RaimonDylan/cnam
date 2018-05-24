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
  if((semid =semget(IPC_PRIVATE,5,IPC_CREAT|IPC_EXCL|0600))==-1){
    perror("\nerreur création de sémaphore");
    exit(1);
  }
  if((semid2 =semget(IPC_PRIVATE,5,IPC_CREAT|IPC_EXCL|0600))==-1){
    perror("\nerreur création de sémaphore");
    exit(1);
  }

  semctl(semid,0,SETVAL,0);
  semctl(semid,1,SETVAL,0);
  semctl(semid,2,SETVAL,0);
  semctl(semid,3,SETVAL,0);
  semctl(semid,4,SETVAL,0);
  semctl(semid2,0,SETVAL,0);
  semctl(semid2,1,SETVAL,0);
  semctl(semid2,2,SETVAL,0);
  semctl(semid2,3,SETVAL,0);
  semctl(semid2,4,SETVAL,0);
  for (int i = 1; i <= 6; i++) {
    if ((retour = fork())==-1) {
      perror("\nEchec de fork");
      exit(2);
    }
    if(retour==0){
      switch (i) {
        case 1:
          while(1){
            couleur("32");
            printf("T1 start\n");
            couleur("31");
            sleep(2);
            V(semid,0);
            P(semid2,0);
            printf("T1 stop\n");
          }
        case 2:
          while(1){
            P(semid,0);
            V(semid2,0);
            couleur("32");
            printf("T2 start stock 0 : %d\n",semctl(semid,0,GETVAL,0));
            sleep(2);
            V(semid,1);
            P(semid2,1);
            couleur("31");
            printf("T2 stop\n");
          }
        case 3:
          while(1){
            P(semid,0);
            V(semid2,0);
            couleur("32");
            printf("T3 start stock 0 : %d\n",semctl(semid,0,GETVAL,0));
            sleep(2);
            V(semid,2);
            P(semid2,2);
            couleur("31");
            printf("T3 stop\n");
          }
        case 4:
          while(1){
            P(semid,1);P(semid,2);
            V(semid2,1);V(semid2,2);
            couleur("32");
            printf("T4 start stock 1 : %d\n",semctl(semid,1,GETVAL,0));
            printf("T4 start stock 2 : %d\n",semctl(semid,2,GETVAL,0));
            sleep(2);
            V(semid,3);
            P(semid2,3);
            couleur("31");
            printf("T4 stop\n");
          }
        case 5:
          while(1){
            P(semid,2);
            V(semid2,2);
            couleur("32");
            printf("T5 start stock 2 : %d\n",semctl(semid,2,GETVAL,0));
            sleep(2);
            couleur("31");
            V(semid,4);
            P(semid2,4);
            printf("T5 stop\n");
            couleur("0");
          }
        case 6:
          while(1){
            potion ++;
            P(semid,3);P(semid,4);
            V(semid2,3);V(semid2,4);
            couleur("32");
            printf("T5 start stock 3 : %d\n",semctl(semid,3,GETVAL,0));
            printf("T5 start stock 4 : %d\n",semctl(semid,4,GETVAL,0));
            sleep(2);
            couleur("31");
            printf("T5 stop\n");
            couleur("33");
            printf("\nNOMBRE DE POTION : %d\n", potion);
          }
      }
    }
  }
  for (int i = 1; i <= 6; i++) {
    wait(&status);
  }
  semctl(semid,0,IPC_RMID);
  exit(0);
}
