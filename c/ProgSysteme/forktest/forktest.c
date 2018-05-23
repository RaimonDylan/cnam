#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(){

  int ret = fork(),status;
  int a = 17;
  int id = getpid();
  if(ret!=0)
  {
    while(1){
      printf("#JeSuisPapa%d\n", a);
      a=0;
      wait(&status);
      sleep(1);
    }

  }
  else {
    while (1) {
      printf("#JeSuisEnfant%d\n", a);
      sleep(1);
    }

  }
  printf("identifiant : %d\n",id );
}
