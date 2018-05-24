#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(){
  system("ps f");
  execl("/bin/ps","ps","f",NULL);
  perror("execl");
  exit(1);
}
