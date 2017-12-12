#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define couleur(param) printf("\033[%sm",param) 

int automate(char *string,int taille){
	int etat = 1;
	for(int i=0;i<taille;i++){
		printf("etat");
		couleur("32");
		printf(" : ");
		couleur("0");
		printf("%d",etat);
		couleur("32");
		printf(" ||| ");
		couleur("0");
		printf("%c\n",string [i]);
		switch( string[i] )   
		{  
		    case 'a':  
		        if(etat==1) etat = 2;
		        else if(etat==2) etat = 3;
		        else if(etat==4) etat =4;
		        else return false;
		        break;
		    case 'b':
		    	if(etat == 3) etat = 4;
		    	else return false;
		    	break;
		    case 'c':
		    	if(etat == 3) etat =1;
		    	else return false;
		    	break;
		    default :  
		    	printf("caratère non autorisé");
		    	couleur("32");
		    	printf(" : ");
		    	couleur("0");
		        printf("%c",string[i]);
		        printf("\n");
		        return false; 
		}
	}
	if(etat == 4) return 1;
	else return 0;
}

void main(int argc, char *argv[]){
	printf("\033[H\033[2J"); // clear dans la console linux 
	couleur("32");
	printf("	AUTOMATE");
	printf("\n");
	couleur("0");
	printf("test de");
	couleur("32");
	printf(" : ");
	couleur("0");
	printf("%s\n",argv[1]);
	printf("\n");
	printf("\n");
	int  taille = atoi(argv[2]) ;
	int res = automate(argv[1],taille);
	printf("\n");
	couleur("32");
	printf("Resultat : ");
	couleur("0");
	if(res == 1)
		printf("true");
	else
		printf("false");
	printf("\n");
}