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
  oper.sem_num = ns; oper.sem_op = -2; oper.sem_flg=0;
  if(semop(semid,&oper,1)==-1){
    perror("\nImpossible de decrementer le sémaphore");
    exit(3);
  }
}

int V(int semid, int ns){
  struct sembuf oper;
  oper.sem_num = ns; oper.sem_op = 2; oper.sem_flg=0;
  if(semop(semid,&oper,1)==-1){
    perror("\nImpossible de d'incrementer le sémaphore");
    exit(4);
  }
}




int main(int argc,char *argv[]){
  int semid,semid2,i,status; pid_t retour;
  //sigset_t ens1;
  //sigemptyset(&ens1);sigaddset(&ens1,SIGINT);sigaddset(&ens1,SIGQUIT);sigaddset(&ens1,SIGUSR1);
  //sigprocmask(SIG_SETMASK,&ens1,NULL);
  if((semid =semget(IPC_PRIVATE,5,IPC_CREAT|IPC_EXCL|0600))==-1){
    perror("\nerreur création de sémaphore");
    exit(1);
  }

  semctl(semid,0,SETVAL,5);
  for (int i = 1; i <= 5; i++) {
    if ((retour = fork())==-1) {
      perror("\nEchec de fork");
      exit(2);
    }
    if(retour==0){
      srand(getpid());
      while(1){
        couleur("32");
        printf("Philosophe n°%d pense \n",i);
        sleep(rand()%10+1);
        P(semid,0);
        couleur("33");
        int nb = semctl(semid,0,GETVAL,0);
        int nbU = (nb==5)?0:(nb==3)?1:2;
        printf("Philosophe n°%d mange\n",i);
        printf("Nombre de philosophe entrain de manger : %d \n",nbU);
        sleep(rand()%6+1);
        V(semid,0);
        int nb2 = semctl(semid,0,GETVAL,0);
        int nbU2 = (nb2==5)?0:(nb2==3)?1:2;
        printf("Nombre de philosophe entrain de manger : %d \n",nbU2);
      }
    }
  }
  for (int i = 1; i <= 5; i++) {
    wait(&status);
  }
  semctl(semid,0,IPC_RMID);
  exit(0);
}
