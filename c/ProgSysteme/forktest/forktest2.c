#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(){

  pid_t pid;
  int global = 0;
  if((pid=fork())==-1){
    perror("Fork ..");
    exit(1);
  }
  printf("Pere et fils\n");
  if(pid==0)
  {
    while(1){
      printf("Fils, PID : %d, PPID : %d ,global : %d\n", getpid(), getppid(),global++);
      sleep(1);
    }
  }
  else {
    while (1) {
      printf("Pere, PID : %d, PPID : %d ,global : %d\n", getpid(), getppid(),global);
      sleep(1);
    }

  }
  exit(0);
}
