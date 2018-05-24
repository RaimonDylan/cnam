#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main(){

  pid_t pid,pidfils;
  int status;
    switch(pid = fork()){
      case (pid_t)-1 :
        perror("naufrage ..");
        exit(2);
      case (pid_t)0 :
        while(1) sleep(1);
      default:
      printf("%d\n", pid);
      sleep(10);
      if(kill(pid,0) == -1){
        printf("processus fils %d inexistant\n",pid);
        exit(1);
      } else{
        printf("envoi de SIGUSR1 au fils %d\n",pid);
        kill(pid,SIGUSR1);
      }
        pidfils = wait(&status);
        printf("Mort de %d, status=%d\n", pidfils,status);
    }

}
