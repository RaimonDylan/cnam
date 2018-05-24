#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/sem.h>
#include <sys/wait.h>


int main(int argc,char *argv[]){
  key_t cle;
  struct sembuf operation;
  int semid;

  if (argc != 3){
    fprintf(stderr, "syntaxe:%s <ref_cle> <nbr>\n",argv[0] );
  }

  if((cle = ftok(argv[1],atoi(argv[2]))) == -1){
    perror("Probleme de clé");
    exit(2);
  }
  if((semid=semget(cle,1,0))==-1){
    perror("Erreur accès");
    exit(1);
  }

  printf("T2 - Attente du sémaphore, opération P\n");

  operation.sem_num = 0;
  operation.sem_op = -1;
  operation.sem_flg = 0;
  if(semop(semid,&operation,1) == -1){
    perror("Impossible de décrémenter le sémaphore");
    exit(3);
  }
  printf("T2 - Début section critique 5 secondes ... \n");
  sleep(10);
  printf("Fin de T2\n");
  semctl(semid,0,IPC_RMID);
}
