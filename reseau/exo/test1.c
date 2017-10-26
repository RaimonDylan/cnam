#include <stdio.h>
#include <stdlib.h>

int main(void){
	char nom[20], car;
	FILE *fic;
	printf("entrez le nom du fichier\n");
	scanf ("%s", nom);
	if ((fic=fopen(nom, "w"))==NULL)
		printf("Erreur de création");
	else
		while(car=getchar() != EOF)
			fputc(car, fic);
	fclose(fic); 
}