#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <time.h>

#define couleur(param) printf("\033[%sm",param) 

struct maillon
{
	int nb;
	int caractere;
	struct maillon *suivant;
};

struct noeud
{
	int valeur;
	struct noeud *fg, *fd;
};

struct noeud *gauche(struct noeud *racine){
	if(racine!=NULL){
		if(racine->fg == NULL)
			return racine;
		else
			gauche(racine->fg);
	}
}


void parcours(struct noeud **racine,struct noeud *origin){
	while(*racine !=NULL){ 
		if(*racine == origin){
			couleur("32");
			printf("   - ");
			couleur("0");
		}
		if((*racine)->fd != NULL && ((*racine)->fd)->valeur != -1){
			printf("%d",1);
			*racine = (*racine)->fd;
		}
		else if((*racine)->fd == NULL && (*racine)->valeur != -1){
			couleur("32");
			printf(" -> ");
			couleur("0");
			printf("%c\n",(*racine)->valeur);
			if(*racine != gauche(origin)){
				(*racine)->valeur = -1;
				*racine = origin;
			}
			else
				*racine = NULL;
		}else{
			if((*racine)->fg != NULL){
				(*racine)->valeur = -1;
				printf("%d",0 );
				*racine = (*racine)->fg;
			}
		}
	}
}

void parcours_g_pre(struct noeud *racine){
	if(racine !=NULL){
		printf("%d ",racine->valeur);
		parcours_g_pre(racine->fg);
		parcours_g_pre(racine->fd);
	}
}


void insereMaillon(int nb,int caractere,struct maillon **liste){
	struct maillon *ptr,*prec,*new;
	prec = NULL;
	new = (struct maillon *)malloc(sizeof(struct maillon));
	ptr = *liste;
	while(ptr != NULL && ptr->nb < nb){
		prec = ptr;
		ptr = ptr->suivant;
	}
	new->nb = nb;
	new->caractere = caractere;
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


void afficheListe(struct maillon *liste){
	couleur("32");
	printf("Liste chainée ordonnée : ");
	couleur("0");
	printf("\n");
	while(liste!= NULL){
		couleur("32");
		printf("   - ");
		couleur("0");
		printf(" nombre de %c", liste->caractere);
		couleur("32");
		printf(" : ");
		couleur("0");
		printf("%d\n", liste->nb);
		liste = liste->suivant;
	}
}

void afficherHisto(int *histo){
	couleur("32");
	printf("Histogramme : ");
	couleur("0");
	printf("\n");
	for(int i=0;i<256;i++){
		if(histo[i]!=0){
			couleur("32");
			printf("   - ");
			couleur("0");
			printf("%c", i );
			couleur("32");
			printf(" = ");
			couleur("0");
			printf("%d\n",histo[i]);

		}
	}
}
int nbElt(struct maillon *liste){
	int cpt = 0;
	while(liste!= NULL){
			cpt++;
			liste = liste->suivant;
	}
	return cpt;
}

struct maillon *plusPetit(struct maillon **liste){
	struct maillon *ptr,*new;
	new = (struct maillon *)malloc(sizeof(struct maillon));
	new->suivant = NULL;
	new->nb = (*liste)->nb;
	new->caractere = (*liste)->caractere;
	ptr = *liste;
	*liste = ptr->suivant;
	free(ptr);
	return new;
}

void insereNoeud(int val,int car1, int car2,struct noeud **racine){
	if(*racine==NULL){
		struct noeud *new,*new1,*new2;
		new = (struct noeud *)malloc(sizeof(struct noeud));
		new1 = (struct noeud *)malloc(sizeof(struct noeud));
		new2 = (struct noeud *)malloc(sizeof(struct noeud));
		new->valeur = val;
		new1->valeur = car1;
		new2->valeur = car2;
		new1->fg = NULL;
		new1->fd = NULL;
		new2->fg = NULL;
		new2->fd = NULL;
		new->fg = new1;
		new->fd = new2;
		*racine = new;
	}else if (car1==0 && car2==0){
		(*racine)->valeur = val;
	}else if (car1== 0 || car2 == 0){
		struct noeud *new,*new1;
		new = (struct noeud *)malloc(sizeof(struct noeud));
		new1 = (struct noeud *)malloc(sizeof(struct noeud));
		if(car1==0)
			new1->valeur = car2;
		else
			new1->valeur = car1;
		new1->fg = NULL;
		new1->fd = NULL;
		new->valeur = val;
		new->fg = *racine;
		new->fd = new1;
		*racine = new;
	}else{
		struct noeud *new,*new1,*new2,*temp;
		new = (struct noeud *)malloc(sizeof(struct noeud));
		new1 = (struct noeud *)malloc(sizeof(struct noeud));
		new2 = (struct noeud *)malloc(sizeof(struct noeud));
		temp = (struct noeud *)malloc(sizeof(struct noeud));
		temp->valeur =-1;
		temp->fg = *racine;
		temp->fd = new;
		new->valeur = val;
		new1->valeur = car1;
		new2->valeur = car2;
		new1->fg = NULL;
		new1->fd = NULL;
		new2->fg = NULL;
		new2->fd = NULL;
		new->fg = new1;
		new->fd = new2;
		*racine = temp;
	}
}
void main(){
	printf("\033[H\033[2J"); // clear dans la console linux 
	char chaine[114] = "aaabbbbbbbbbccccccccccccccccccccccccccccccddddddddddddddddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"; 
	int histo[256] = {0};
	for (int i=0;i<sizeof(chaine);i++)
		histo[chaine[i]]++;
	afficherHisto(histo);
	printf("\n");
	struct maillon *liste = NULL;
	for(int i=0;i<256;i++){
		if(histo[i]!=0){
			insereMaillon(histo[i],i,&liste);
		}
	}
	afficheListe(liste);
	printf("\n");
	struct noeud *racine = NULL;
	while(nbElt(liste)>=2){
		struct maillon *un = plusPetit(&liste);
		struct maillon *deux = plusPetit(&liste);
		int val = un->nb+deux->nb;
		int car1 = un->caractere;
		int car2 = deux->caractere;
		insereNoeud(val,car1,car2,&racine);
		insereMaillon(val,0,&liste);
	}
	couleur("32");
	printf("nouveau code des caracteres : ");
	couleur("0");
	printf("\n");
	parcours(&racine,racine);
	printf("\n");
}