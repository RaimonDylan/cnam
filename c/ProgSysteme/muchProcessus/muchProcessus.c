#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(){
  int a = 0, nbP = 10, status;
  for (size_t i = 0; i < nbP; i++) {
    if(a == 0){
      a = (fork() == 0)?1:0;
      if(a==0) wait(&status);
      else printf("robot n°%d - père : %d\n", getpid(), getppid());
    }
  }
}
