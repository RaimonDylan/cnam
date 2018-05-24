#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/ipc.h>
#include <sys/types.h>
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
  
  exit(0);
}
