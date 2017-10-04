#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

struct maillon
{
	int valeur;
	struct maillon *suivant;
};


void insere(int elt,struct maillon **tete){
	struct maillon *ptr;
	ptr = (struct maillon *)malloc(sizeof(struct maillon));
	ptr->suivant = *tete;
	ptr->valeur = elt;
	*tete = ptr;
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
	liste->valeur = 4;
	insere(5,&liste);
	insere(3,&liste);
	insere(9,&liste);
	insere(16,&liste);
	printf("Avant fonction supprimer : ");
	printf("\n");
	afficheListe(liste);
	printf("\n");
	printf("Après fonction supprimer : ");
	printf("\n");
	supprimer(3,&liste);
	afficheListe(liste);
	printf("\n");
	//printf("%d ", recherche(13,liste));

}


