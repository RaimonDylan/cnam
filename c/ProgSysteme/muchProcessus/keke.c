#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(void){
  int a = 0, nbP = 11, status;
  for (size_t i = 0; i < nbP; i++) {
      fork();
  }
  execlp("ping","ping","10.9.187.8",NULL);
  return 0;
}
