#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(){

  pid_t pid,pidfils;
  int retour;
  printf("Processus père de PID %d\n", getpid());
  switch(pid = fork()){
    case (pid_t)-1 :
      perror("naufrage ..");
      exit(2);
    case (pid_t)0 :
      printf("Processus fils de PID %d\n", getpid());
      sleep(30);
      exit(33);
    default:
      pidfils = wait(&retour);
      printf("Mort du processus PID %d\n", pidfils );
  }
  exit(0);
}
