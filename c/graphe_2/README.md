# 2ème Graphe
```c
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <time.h>
#include <limits.h>

#define couleur(param) printf("\033[%sm",param) 


struct maillon
{
	int valeur;
	struct maillon *suivant;
};


void enfiler(int valeur, struct maillon **tete, struct maillon **queue){
	struct maillon *new;
	new = (struct maillon *)malloc(sizeof(struct maillon));
	new->valeur = valeur;
	if(*tete==NULL){
		new->suivant = NULL;
		*tete = new;
		*queue = new;
	}else{
		new->suivant = NULL;
		(*queue)->suivant = new;
		*queue = new;
	}
}

void chemin(int d,int val_p,int *pred){ 
	int tab[6] = {0};
	int i = 0;
	tab[i] = d+1;
	//printf("%d",d+1);
	//printf(" -> ");
	while(val_p != -1){
		i++;
		tab[i] = val_p+1;
		//printf("%d",val_p+1);
		val_p = pred[val_p];
		//if(val_p != -1)
			//printf(" -> ");
	}
	for (int i = 5; i >= 0; --i)
	{
		if(tab[i]!=0){
			couleur("32");
			printf("%d",tab[i]);
			couleur("0");
			if(tab[i] != d+1)
				printf(" -> ");
		}
	}
}

int defiler(struct maillon **tete){
	if(*tete==NULL)
		return -1;
	else{
		int valeur = (*tete)->valeur;
		struct maillon *suivant = (*tete)->suivant;
		free(*tete);
		*tete = suivant;
		return valeur;
	}
}

void distance(int **g,int sd,unsigned int *d, int *pred){
	d[sd] = 0;
	struct maillon *tete=NULL;
	struct maillon *queue=NULL;
	enfiler(sd,&tete,&queue);
	while(tete != NULL){
		int s = defiler(&tete);
		for (int i = 0; i < 6; ++i)
		{
			if(g[s][i] > 0)
				if(d[i] > d[s]+g[s][i]){
					d[i] = d[s]+g[s][i];
					enfiler(i,&tete,&queue);
					pred[i] = s;
				}
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
	g[0][1] = 1;
	g[0][3] = 12;
	g[1][3] = 8;
	g[1][2] = 3;
	g[2][4] = 4;
	//g[3][5] = 2;
	//g[4][5] = 1;
	//g[5][4] = 1;
	//g[5][3] = 2;
	g[4][2] = 4;
	g[2][1] = 3;
	g[3][1] = 8;
	g[3][0] = 12;
	g[1][0] = 1;
	printf("Matrice : \n");
	printf("\n");
	couleur("32");
	printf("     _________________\n");
	couleur("0");
	for (int i = 0; i < 6; ++i)
	{
		printf("%d",i+1);
		printf("   ");
		for (int j = 0; j < 6; ++j)
		{
			couleur("32");
			if(g[i][j]<10)
				printf("| ");
			else
				printf("|");
			couleur("0");
			printf("%d",g[i][j]);
		}
		couleur("32");
		printf("|");
		printf("\n");
		couleur("0");
	}
	
	unsigned int d[6];
	int pred[6];
	int inf = INT_MAX; 
	
	for (int i = 0; i < 6; ++i)
	{
		d[i] = inf;
		pred[i] = -1;
	}
	printf("\n");
	int sd = 0; // Sommet de départ
	distance(g,sd,d,pred);
	printf("Chemin le plus court à partir du sommet : ");
	printf("%d",sd+1);
	printf("\n");
	for (int i = 0; i < 6; ++i)
	{
		couleur("32");
		printf(" - ");
		couleur("0");
		printf("distance entre ");
		printf("%d",sd+1);
		printf(" et ");
		printf("%d",i+1);
		printf(" = ");
		couleur("32");
		if(d[i] != inf){
			printf("%d",d[i]);
			couleur("0");
			if(i!=sd){
				printf(" chemin : ");
				couleur("32");
				chemin(i,pred[i],pred);
				couleur("0");
			}
		}else{
			printf("pas de chemin");
			couleur("0");
		}
		printf("\n");
	}
	
}
```
