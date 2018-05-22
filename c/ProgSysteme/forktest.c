#include <stdio.h>
#include <stdlib.h>
#include <unistd>

int main(){
  
  int ret = fork();
  int a = 17;
  int id = getpid();
  if(ret!=0)
  {
    printf("#JeSuisPapa%d\n", a);

  }
  else printf("#JeSuisEnfant%d\n", a);
  printf("identifiant : %d\n",id );
}
