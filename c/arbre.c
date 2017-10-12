#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <time.h>

struct noeud
{
	int valeur;
	struct noeud *fg, *fd;
};
void parcours_g_pre(struct noeud *racine){
	if(racine !=NULL){
		printf("%d ",racine->valeur);
		parcours_g_pre(racine->fg);
		parcours_g_pre(racine->fd);
	}
}

void parcours_d_pre(struct noeud *racine){
	if(racine !=NULL){
		printf("%d ",racine->valeur);
		parcours_d_pre(racine->fd);
		parcours_d_pre(racine->fg);
	}
}

void parcours_g_inf(struct noeud *racine){
	if(racine !=NULL){
		parcours_g_inf(racine->fg);
		printf("%d ",racine->valeur);
		parcours_g_inf(racine->fd);
	}
}

void parcours_d_inf(struct noeud *racine){
	if(racine !=NULL){
		parcours_d_inf(racine->fd);
		printf("%d ",racine->valeur);
		parcours_d_inf(racine->fg);
	}
}

void parcours_g_post(struct noeud *racine){
	if(racine !=NULL){
		parcours_g_post(racine->fg);
		parcours_g_post(racine->fd);
		printf("%d ",racine->valeur);
	}
}

void parcours_d_post(struct noeud *racine){
	if(racine !=NULL){
		parcours_d_post(racine->fd);
		parcours_d_post(racine->fg);
		printf("%d ",racine->valeur);
	}
}

void insere(int val, struct noeud **racine){
	if(*racine==NULL){
		struct noeud *new;
		new = (struct noeud *)malloc(sizeof(struct noeud));
		new->valeur = val;
		new->fg = NULL;
		new->fd = NULL;
		*racine = new;
	}else if((*racine)->valeur>val){
		if((*racine)->fg!=NULL)
			insere(val,&((*racine)->fg));
		else{
			struct noeud *new;
			new = (struct noeud *)malloc(sizeof(struct noeud));
			new->valeur = val;
			new->fg = NULL;
			new->fd = NULL;
			(*racine)->fg = new;
		}
	}else if((*racine)->fd!=NULL){
		insere(val,&((*racine)->fd));
	}else{
		struct noeud *new;
		new = (struct noeud *)malloc(sizeof(struct noeud));
		new->valeur = val;
		new->fg = NULL;
		new->fd = NULL;
		(*racine)->fd = new;
	}
}

struct maillon
{
	struct noeud *noeud;
	struct maillon *suivant;
};


void enfiler(struct noeud *n, struct maillon **tete, struct maillon **queue){
	struct maillon *new;
	new = (struct maillon *)malloc(sizeof(struct maillon));
	new->noeud = n;
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



struct noeud *defiler(struct maillon **tete){
	if(*tete==NULL)
		return NULL;
	else{
		struct noeud *noeud = (*tete)->noeud;
		struct maillon *suivant = (*tete)->suivant;
		free(*tete);
		*tete = suivant;
		return noeud;
	}
}

void afficheListe(struct maillon *liste){
	while(liste!= NULL){
		printf("%d ", liste->noeud->valeur);
		liste = liste->suivant;
	}
}

void parcours_largeur(struct maillon *tete){
	if(tete!=NULL){
		struct noeud *noeud;
		struct maillon *tete2=NULL;
		struct maillon *queue2=NULL;
		while(tete!=NULL){
			noeud = defiler(&tete);
			if(noeud!=NULL){
				if(noeud->fg!=NULL)
					enfiler(noeud->fg,&tete2,&queue2);
				if(noeud->fd!=NULL)
					enfiler(noeud->fd,&tete2,&queue2);
				printf("%d ",noeud->valeur);
			}
		}
		if(tete2!=NULL){
			parcours_largeur(tete2);
		}
	}
}


#define couleur(param) printf("\033[%sm",param) 


void main(){
	printf("\033[H\033[2J"); // clear dans la console linux 
	struct noeud *racine = NULL;
	// CREATION DE L'ARBRE
	for (int i = 0; i < 20; ++i)
	{
		int nb_alea = rand()%(100);
		insere(nb_alea,&racine);
	}
	couleur("7"); // inversion de la couleur et du fond
	printf("Parcours de mon arbre par la gauche inf :\n");
	couleur("0");
	parcours_g_inf(racine);
	printf("\n");

	couleur("7");
	printf("Parcours de mon arbre par la droite inf :\n");
	couleur("0");
	parcours_d_inf(racine);
	printf("\n");

	couleur("7");
	printf("Parcours de mon arbre par largeur : \n");
	couleur("0");
	struct maillon *tete=NULL;
	struct maillon *queue=NULL;
	enfiler(racine,&tete,&queue);
	parcours_largeur(tete);
/*	printf("Parcours de ma file : \n");
	enfiler(racine,&tete,&queue);
	enfiler(racine->fg,&tete,&queue);
	afficheListe(tete);
	printf("\n");
	printf("defiler : \n");
	defiler(&tete);
	afficheListe(tete);
	printf("\n");
	printf("enfiler : \n");
	enfiler(racine->fd,&tete,&queue);*/
	//afficheListe(tete);
	printf("\n");
}