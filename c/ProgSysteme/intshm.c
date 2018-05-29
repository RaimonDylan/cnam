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
int *num=0;
int *lect=0;
int semid;

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

void lecteur(int i){
  while(1){
    P(semid,2);
    lect++;
    if((*lect)==1) P(semid,1);
    V(semid,2);
    couleur("32");
    printf("Lecteur   ");
    couleur("33");
    printf("[%d]",i );
    couleur("32");
    printf("  Variable");
    couleur("33");
    printf("[%d]\n",*num );
    P(semid,2);
    lect--;
    if((*lect)==0) V(semid,1);
    V(semid,2);
    sleep(5);
  }
}
void redacteur(int i){
  while(1){
    P(semid,0);
    P(semid,1);
    (*num)++;
    couleur("31");
    printf("Redacteur ");
    couleur("33");
    printf("[%d]",i );
    couleur("32");
    printf("  Variable");
    couleur("33");
    printf("[%d]\n",*num );
    couleur("33");
    V(semid,0);
    V(semid,1);
    sleep(2);
  }
}

int main(int argc,char *argv[]){
  int i,status; pid_t retour;
  key_t key; int flag, id;
  flag=IPC_CREAT|0600;
  if ((id=shmget(IPC_PRIVATE,512,flag))<0) exit(1);
  if((semid =semget(IPC_PRIVATE,3,IPC_CREAT|IPC_EXCL|0600))==-1){
    perror("\nerreur création de sémaphore");
    exit(1);
  }
  if ((num=shmat(id,0,0))<0) exit(2);
  if ((lect=shmat(id,0,0))<0) exit(2);
  semctl(semid,0,SETVAL,1);
  semctl(semid,1,SETVAL,1);
  semctl(semid,2,SETVAL,1);
  for (int i = 1; i <= 5; i++) {
    if ((retour = fork())==-1) {
      perror("\nEchec de fork");
      exit(2);
    }
    if(retour==0){
      if(i<=3) lecteur(i);
      if(i>3) redacteur(i);
    }
  }
  wait(&status);
  shmdt(num);
  shmctl(id,IPC_RMID,0);
  exit(0);
}
