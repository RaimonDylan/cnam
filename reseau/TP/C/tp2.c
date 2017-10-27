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
	wait(0);
	if (pid==0){
		for (int i=0;i<=50; i++)
			printf("enfant : %d\n",i );
	}
	else{
			for (int i=51;i<=100; i++)
					printf("papa : %d\n",i );
	}
	return 0;
}