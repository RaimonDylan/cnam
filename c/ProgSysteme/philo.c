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

int P2(int semid, int ns, int ns2){
  struct sembuf oper[2];
  oper[0].sem_num = ns; oper[0].sem_op = -1; oper[0].sem_flg=0;
  oper[1].sem_num = ns2; oper[1].sem_op = -1; oper[1].sem_flg=0;
  if(semop(semid,oper,1)==-1){
    perror("\nImpossible de decrementer le sémaphore");
    exit(3);
  }
}

int V2(int semid, int ns, int ns2){
  struct sembuf oper[2];
  oper[0].sem_num = ns; oper[0].sem_op = 1; oper[0].sem_flg=0;
  oper[1].sem_num = ns2; oper[1].sem_op = 1; oper[1].sem_flg=0;
  if(semop(semid,oper,1)==-1){
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

  semctl(semid,0,SETVAL,1);
  semctl(semid,1,SETVAL,1);
  semctl(semid,2,SETVAL,1);
  semctl(semid,3,SETVAL,1);
  semctl(semid,4,SETVAL,1);
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
        int a = (i==5)?0:i;
        P2(semid,i-1,a);
        couleur("33");
        int nb = semctl(semid,0,GETVAL,0) + semctl(semid,1,GETVAL,0) +semctl(semid,2,GETVAL,0) +semctl(semid,3,GETVAL,0) +semctl(semid,4,GETVAL,0);
        int nbU = (nb==5)?0:(nb==3)?1:2;
        printf("Philosophe n°%d mange\n",i);
        printf("Nombre de philosophe entrain de manger : %d \n",nbU);
        sleep(rand()%6+1);
        int b = (i==5)?0:i;
        V2(semid,b,i-1);
        int nb2 = semctl(semid,0,GETVAL,0) + semctl(semid,1,GETVAL,0) +semctl(semid,2,GETVAL,0) +semctl(semid,3,GETVAL,0) +semctl(semid,4,GETVAL,0);
        int nbU2 = (nb2==5)?0:(nb2==3)?1:2;
        printf("Nombre de philosophe entrain de manger : %d \n",nbU2);
      }
    }
  }
  for (int i = 1; i <= 5; i++) {
    wait(&status);
  }
  semctl(semid,0,IPC_RMID);
  semctl(semid,1,IPC_RMID);
  exit(0);
}
