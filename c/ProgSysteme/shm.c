#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/sem.h>
#include <sys/shm.h>
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
  couleur("33");
  int semid,semid2,i,status; pid_t retour;
  key_t key; int flag, id; char *buf;
  flag=IPC_CREAT|0600;
  if((key =ftok("macle",12)) == -1) {  perror("Probleme de cle");  exit(2);  }
  if((semid =semget(key,1,IPC_CREAT|IPC_EXCL|0600))==-1){
    perror("\nerreur création de sémaphore");
    exit(1);
  }
  if ((id=shmget(key,512,flag))<0) exit(1);
  if ((buf=shmat(id,0,0))<0) exit(2);
  strcpy(buf,"Bonjour");
  sleep(100);
  shmdt(buf);
  exit(0);
}
