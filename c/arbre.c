#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

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

void parcours_largeur(struct maillon **tete, struct maillon **queue){
	if(*tete!=NULL){

		struct noeud *noeud;
		struct maillon *tete2=NULL;
		struct maillon *queue2=NULL;
		while(*tete!=NULL){
			noeud = defiler(&(*tete));
			enfiler(noeud->fg,&tete2,&queue2);
			enfiler(noeud->fd,&tete2,&queue2);
			printf("%d ",noeud->valeur);
		}
		if(tete2!=NULL){
			parcours_largeur(&tete2,&queue2);
		}
	}
	
}

void afficheListe(struct maillon *liste){
	while(liste!= NULL){
		printf("%d ", liste->noeud->valeur);
		liste = liste->suivant;
	}
}


void main(){
	struct noeud *racine = NULL;
	insere(20,&racine);
	insere(17,&racine);
	insere(28,&racine);
	insere(4,&racine);
	insere(10,&racine);
	insere(23,&racine);
	insere(33,&racine);
	printf("Parcours de mon arbre par la gauche : \n");
	parcours_g_pre(racine);
	printf("\n");
	printf("Parcours de mon arbre par largeur : \n");
	struct maillon *tete=NULL;
	struct maillon *queue=NULL;
	enfiler(racine,&tete,&queue);
	afficheListe(tete);
	printf("\n");
	parcours_largeur(&tete,&queue);
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