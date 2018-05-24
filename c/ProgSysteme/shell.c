#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main(){

  pid_t pid,pidfils;
  int retour;
  char buffer[1024];
  while(1){
    printf("[prompt]> ");
    fgets(buffer,1024,stdin);
    if(buffer[strlen(buffer)-1] == '\n')buffer[strlen(buffer)-1] = '\0';
    if(strcmp(buffer,"exit") == 0){printf("Adieu ...\n");exit(0);}
    switch(pid = fork()){
      case (pid_t)-1 :
        perror("naufrage ..");
        exit(2);
      case (pid_t)0 :
        execlp(buffer,buffer,NULL);
        fprintf(stderr, "Commande inconnue ...\n");
        exit(1);
      default:
        pidfils = wait(&retour);
    }
  }

}
