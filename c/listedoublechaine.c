#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

struct maillon
{
	int valeur;
	struct maillon *suivant;
	struct maillon *prec;
};


void insere(int elt,struct maillon **ptr){
	struct maillon *new;
	new = (struct maillon *)malloc(sizeof(struct maillon));
	new->valeur = elt;
	if(*ptr==NULL){
		new->suivant = NULL;
		new->prec = NULL;
		*ptr=new;
	}else if((*ptr)->suivant == NULL){
		new->suivant = NULL;
		(*ptr)->suivant = new;
		new->prec = *ptr;
	}else{
		new->suivant = (*ptr)->suivant;
		(*ptr)->suivant = new;
		new->suivant->prec = new;
		new->prec = *ptr;
	}
}

void supprimer(struct maillon **tete, struct maillon *ptr){
	if(*tete!=NULL){
		if(ptr==*tete){
			*tete=ptr->suivant;
			if(*tete!=NULL)
				(*tete)->prec = NULL;
		}else if(ptr->suivant == NULL){
			if(ptr->prec !=NULL)
				ptr->prec->suivant = NULL;
		}else{
			ptr->suivant->prec = ptr->prec;
			ptr->prec->suivant = ptr->suivant;
		}
		free(ptr);
	}
}

struct maillon *recherche(struct maillon *tete){
	struct maillon *ptr,*ptrgros;
	ptr=tete;
	if(ptr!=NULL){
		ptrgros = ptr;
	}
	while(ptr!=NULL){
		if(ptr->valeur > ptrgros->valeur)
			ptrgros = ptr;
		ptr = ptr->suivant;
	}
	if(tete!=NULL)
		return ptrgros;
	else
		return NULL;
}



void afficheListe(struct maillon *liste){
	while(liste!= NULL){
		printf("%d ", liste->valeur);
		liste = liste->suivant;
	}
}

void main(){
	struct maillon *liste;
	liste = (struct maillon *)malloc(sizeof(struct maillon));
	liste->suivant = NULL;
	liste->valeur = 4;
	liste->prec = NULL;
	insere(5,&liste);
	insere(3,&liste);
	insere(9,&liste);
	insere(16,&liste);
	printf("Le plus gros : ");
	printf("\n");
	struct maillon *gros = recherche(liste);
	printf("%d ", gros->valeur);
	printf("\n");
	printf("Avant fonction supprimer : ");
	printf("\n");
	afficheListe(liste);
	printf("\n");
	supprimer(&liste,gros);
	printf("Après fonction supprimer : ");
	printf("\n");
	//supprimer(&liste);
	afficheListe(liste);
	printf("\n");
	//printf("%d ", rrecherche(13,liste));

}


