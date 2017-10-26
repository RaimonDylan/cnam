#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
const char * quiSuisJe=NULL;

#define couleur(param) printf("\033[%sm",param) 

int main(){
	printf("\033[H\033[2J"); // clear dans la console linux 
	pid_t pid ;
	quiSuisJe= "le père";
	pid=fork();
	if (pid==0){
		quiSuisJe="le fils";
		couleur("7"); // inversion de la couleur et du fond
		printf("je suis %s\n", quiSuisJe);
	}
	else{
		printf("je suis %s\n", quiSuisJe);
	}
	couleur("0");
	return 0;
}