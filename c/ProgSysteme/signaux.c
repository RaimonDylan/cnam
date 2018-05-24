#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/wait.h>

int main(){

  sigset_t ens1,ens2;
  sigemptyset(&ens1);sigaddset(&ens1,SIGINT);sigaddset(&ens1,SIGQUIT);sigaddset(&ens1,SIGUSR1);
  sigprocmask(SIG_SETMASK,&ens1,NULL);
  printf("Masquage en place pour 20 secondes\n");
  sleep(20);

  sigpending(&ens2);
  printf("Signaux pendant :\n");
  for (int i = 0; i < NSIG; i++)
    if(sigismember(&ens2,i)) printf("%d\n",i );
  sigemptyset(&ens1);
  printf("debloquage des signaux\n");
  sigprocmask(SIG_SETMASK,&ens1,NULL);
  sleep(1);
  printf("Fin normal du processus\n");
  exit(0);

}
