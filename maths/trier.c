#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

void trier(int tab[],int taille){
	int inter;
	bool nontrier = true;
	while(nontrier){
		nontrier = false;
		for (int i = 0; i < taille; ++i)
		{
			if(tab[i]>tab[i+1]){
				inter = tab[i+1];
				tab[i+1] = tab[i];
				tab[i] = inter;
				nontrier = true;
			}
		}
	}
	for (int i = 0; i < taille; ++i)
	{
		printf("%d ", tab[i]);
	}
	
}

void trier_selection(int tab[], int taille, int d, int f){
	if(d==f){
		for (int i = 0; i < taille; ++i)
		{
			printf("%d ", tab[i]);
		}
		printf("\n");
	}
	else{
		int petit = tab[d];
		for (int i = 0; i < taille; ++i)
		{
			if(petit<tab[i]){
				petit = tab[i];
				tab[i] = tab[d];
				tab[d] = petit;
			}
		}
		d++;
		return trier_selection(tab,taille,d,f);
	}
	
}
void fusion(int *t, int d,int m, int f){
	int debut = d;
	int f2 = m;
	int *tab;
	tab = (int*)malloc((f-d)*sizeof(int));
	for (int i = 0; i < (f-debut); i++)
	{
		if(m==f){
			tab[i] = t[d];
			d++;
		}
		else if(d==f2){
			tab[i] = t[m];
			m++;
		}
		else if(t[d]<t[m]){
			tab[i] = t[d];
			d++;
		}
		else if(t[d]>t[m]){
			tab[i] = t[m];
			m++;
		}
	}
	for (int i = 0; i < (f-debut); i++)
	{
		t[debut+i] = tab[i];
	}
}

void tri_f(int *t, int d, int f){
	int m;
	if((d+f)%2==0){
		m=((d+f)/2);
	}
	else{
		m=((d+f)/2)+1;
	}
	if(d!=f){
		tri_f(t,d,m-1);
		tri_f(t,m,f);
		fusion(t,d,m,f);
	}
}

void main(){
	int t[] = {2,23,43,51,3,24,25,8};
	int taille = 8;
	//trier(t,10);
	//trier_selection(t,taille,0,10);
	//fusion(t,0,4,7);
	tri_f(t,0,8);

	//TEST

	for (int i = 0; i < taille; ++i)
	{
		printf("%d ", t[i]);
	}
	printf("\n");
}