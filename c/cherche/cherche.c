#include <stdio.h>

// RECHERCHE DICHOTOMIQUE
int cherche(int tab[], int taille, int nb){
	int d = 0;
	int f = taille;
	int m=((d+f)/2);
	while(f!=d){
		m=((d+f)/2);
		if(nb == tab[m]){
			return m;
		}
		else if(nb>tab[m]){
			d=m+1;
		}
		else{
			f=m-1;
		}
		if(nb == tab[f]){
			return f;
		}
		if(f-d==1){
			m=((d+f)/2);
			if(nb!=tab[m]){
				return -1;
			}
		}
	}
	return -1;
}

// RECHERCHE DICHOTOMIQUE RECURSIVE
int cherche2(int tab[], int taille, int nb, int d, int f){
	int m=((d+f)/2);
	if(nb == tab[m]){
		return m;
	}
	else if(nb>tab[m]){
		d=m+1;
	}
	else if(nb<tab[m]){
		f=m-1;
	}
	if(nb == tab[f]){
		return f;
	}
	if(f-d==1){
		m=((d+f)/2);
		if(nb!=tab[m]){
			return -1;
		}
	}
	return cherche2(tab,taille,nb,d,f);
}

void main(){
	int nb, choix =0;
	int t[] = {0,5,8,17,29,32,38,40,45,48,49};
	while(choix!=1 && choix!=2){
		printf("Recherche par dicho(1) ou par recursivité(2) ?\n");
		scanf("%d", &choix);
	}
	printf("Saisir un nombre :\n");
	scanf("%d", &nb);
	if(choix == 1){
		printf("%d\n",cherche(t,10,nb));	
	}
	else{
		int d = 0;
		int f = 10;
		printf("%d\n",cherche2(t,10,nb,d,f));
	}
	
}
