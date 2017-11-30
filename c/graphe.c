#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <time.h>

#define couleur(param) printf("\033[%sm",param) 

void parcours(int **g){
	int marques[6] = {0};
	for (int i = 0; i < 6; ++i)
	{
		if(marques[i] == 0)
			p_profondeur(g,i,marques);
	}
}

void p_profondeur(int **g, int s, int *marques){
	if(marques[s] == 0){
		marques[s] = 1;
		printf("%d",s+1);
		for (int i = 0; i < 6; ++i)
		{
			if(g[s][i] == 1)
				p_profondeur(g,i,marques);
		}
	}
}

void main(){
	printf("\033[H\033[2J"); // clear dans la console linux 
	int n = 6; // nb sommets
	int **g = NULL;
	g=malloc(sizeof(int*)*n);
    for(int i = 0;i < n;i++)
        g[i]=malloc(sizeof(int)*n);
	// Création du graphe 
	/*g[0][1] = 1;
	g[0][2] = 1;
	g[1][0] = 1;
	g[1][2] = 1;
	g[1][3] = 1;
	g[2][0] = 1;
	g[2][1] = 1;
	g[2][5] = 1;
	g[3][1] = 1;
	g[4][5] = 1;
	g[5][2] = 1;
	g[5][4] = 1;*/
	g[0][1] = 1;
	g[0][3] = 12;
	g[1][3] = 8;
	g[1][2] = 3;
	g[2][4] = 4;
	g[3][5] = 2;
	g[4][5] = 1;
	g[5][4] = 1;
	g[5][3] = 2;
	g[4][2] = 4;
	g[2][1] = 3;
	g[3][1] = 8;
	g[3][0] = 12;
	g[1][0] = 1;
	printf("Matrice : \n");
	printf("    123456\n");
	printf("    ______\n");
	for (int i = 0; i < 6; ++i)
	{
		printf("%d",i+1);
		printf(" | ");
		for (int j = 0; j < 6; ++j)
		{
			if(g[i][j]>0)
				printf("%d",1);
			else
				printf("%d",g[i][j] );
		}
		printf("\n");
	}
	printf("\n");
	printf("Parcours en profondeur du graphe :  \n");
	parcours(g);
	printf("\n");
}