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

int main(int argc,char *argv[]){
  couleur("35");
  int semid,semid2,i,status; pid_t retour;

  key_t key; int flag, id; char *buf;
  flag=0;
  if((key =ftok("macle",12)) == -1) {  perror("Probleme de cle");  exit(2);  }
  if ((id=shmget(key,512,flag))<0) exit(1);
  if((semid =semget(key,1,0))==-1){
    perror("\nerreur création de sémaphore");
    exit(1);
  }
  if ((buf=shmat(id,0,0))<0) exit(2);
  printf("Contenu : %s\n", buf);
  shmdt(buf);
  shmctl(id,IPC_RMID,0);
  exit(0);
}
