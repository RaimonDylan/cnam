#include <stdio.h>
#include <stdlib.h>

int main(void){
	char nom[20], car;
	FILE *fic;
	printf("entrez le nom du fichier\n");
	scanf ("%s", nom);
	if ((fic=fopen(nom, "r"))==NULL)
		printf("Erreur d’ouverture");
	else
		while(car=fgetc(fic) != EOF)
			putchar(car);
	fclose(fic);
}
