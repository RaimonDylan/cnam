#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

struct maillon
{
	int valeur;
	struct maillon *suivant;
};


void insere(int elt,struct maillon **liste){
	struct maillon *ptr,*prec,*new;
	prec = NULL;
	new = (struct maillon *)malloc(sizeof(struct maillon));
	ptr = *liste;
	while(ptr != NULL && ptr->valeur < elt){
		prec = ptr;
		ptr = ptr->suivant;
	}
	new->valeur = elt;
	if(ptr!=NULL){
		if(prec!=NULL){
			new->suivant = prec->suivant;
			prec->suivant = new;
		}
		else{
			new->suivant = *liste;
			*liste = new;
		}
	}else{
		new->suivant = NULL;
		if(prec!=NULL){
			prec->suivant = new;
		}else{
			*liste = new;
		}
	}
}

int recherche (int val, struct maillon *liste){
	struct maillon *ptr;
	ptr = liste;
	while(ptr!= NULL && ptr->valeur != val){
		ptr = ptr->suivant;
	}
	if(ptr == NULL){
		return 0;
	}else{
		return 1;
	}
}

void supprimer(int val, struct maillon **liste){
	struct maillon *ptr, *prec;
	ptr = *liste;
	while(ptr != NULL && ptr->valeur != val){
		prec = ptr;
		ptr = ptr->suivant;
	}
	if(ptr!=NULL){
		if(prec == NULL)
			*liste = ptr->suivant;
		else
			prec->suivant = ptr->suivant;
		free(ptr);
	}
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
	liste->valeur = 3;
	insere(5,&liste);
	insere(16,&liste);
	insere(2,&liste);
	insere(7,&liste);
	insere(28,&liste);
	afficheListe(liste);
	printf("\n");

}


