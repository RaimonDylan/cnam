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
  if(WIFEXITED(retour)){
    printf("code de retour :%d\n",WEXITSTATUS(retour));
    exit(0);
  }
  if(WIFSIGNALED(retour)){
    printf("tué par le signal %d\n",WTERMSIG(retour));
    if(WCOREDUMP(retour))
      printf("fichier core crée\n");
    exit(1);
  }
  exit(0);
}
