#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#include <sys/wait.h>
const char * quiSuisJe=NULL;


int main(){
	printf("\033[H\033[2J"); // clear dans la console linux 
	pid_t pid ;
	int status ;
	pid=fork();
	if (pid==0){
		for (int i=0;i<=100; i++){
			if(i%2 == 0){
				printf("enfant : %d\n",i );
				kill(getppid(),SIGUSR1);
				pause();
			}

		}
	}
	else{
		printf("%d\n",pid );
			for (int i=0;i<=100; i++){
				if(i%2==1){
					printf("%d\n",pid );
					pause();
					printf("papa : %d\n",i );
					kill(pid,SIGUSR1);
				}
			}
	}
	return 0;
}