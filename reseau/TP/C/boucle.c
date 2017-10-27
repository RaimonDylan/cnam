#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <time.h>
const char * quiSuisJe=NULL;

#define couleur(param) printf("\033[%sm",param) 

int main(){
	printf("\033[H\033[2J"); // clear dans la console linux 
	pid_t pid ;
	quiSuisJe= "le père";
	pid=fork();
	if (pid==0){
		quiSuisJe="le fils";
		printf("je suis %s\n", quiSuisJe);
	}
	else{
		printf("je suis %s\n", quiSuisJe);
	}
	int t =1;
	
	while(t>0){
		int nbgen = rand()%8+40;
		switch (nbgen)
		{
			case 40:
			  couleur("40");
			  break;
			case 41:
			  couleur("41");
			  break;
			case 42:
			  couleur("42");
			  break;
			case 43:
			  couleur("43");
			  break;
			case 44:
			  couleur("44");
			  break;
			case 45:
			  couleur("45");
			  break;
			case 46:
			  couleur("46");
			  break;
			case 47:
			  couleur("47");
			  break;
		}
		printf("%d",nbgen );
	}
	
	couleur("0");
	return 0;
}