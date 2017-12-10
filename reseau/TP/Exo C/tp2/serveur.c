
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <netdb.h>

int balanceTonPorc(struct sockaddr_in addr){
	return addr.sin_port;
}

int main(int argc, char *argv[]){ 

    /* 1. Récupération des paramètres d'entrée */

        short portLoc = (short) atoi(argv[1]) ;		/* numéro de port local */
        char *nomServ;
        nomServ = argv[2];		/* Pointeur sur le nom du serveur */
        short portServ  = (short) atoi(argv[3]) ;		/* numéro de port serveur */
        char *msgEnvoi;
        msgEnvoi = argv[4] ; 		/* Pointeur sur le message à envoyer */
        int  tailleMsgEnvoi= atoi(argv[5]) ;		/* taille du message */
	
        /* 2. Déclaration des variables permettant la communication sur le réseau */

        int sockLoc;	// descripteur de la socket locale (cliente)
        struct hostent* infosServ;   	/* Informations du serveur */
        struct sockaddr_in infosAddrLoc;  	/* Informations d'adressage de la socket locale */
        struct sockaddr_in infosAddrServ;    	/* Informations d'adressage de la socket serveur */
        int tailleInfosAddrLoc, tailleInfosAddrServ ;	/* taille des informations d'adressage de la socket locale */

        char msgRecu [1000] ;	 /* Buffer qui contiendra la réponse du serveur */

        /* 3. Création de la socket en mode connecté, si création réussie retourne son descripteur dans sockLoc, sinon on    
        quitte le programme */
        int sock = socket(AF_INET, SOCK_STREAM, 0);

        // if(sock == INVALID_SOCKET){
        if(sock == -1){
            perror("Socket()");
            exit(errno);
        } else {
            // COMMENT ON FAIT ? //TODO
            sockLoc = sock;
            printf("Socket = %d\n", sock);
            printf("%d\n", sockLoc);
        }

        int errno;
        

		

        /* 4. Mise à jour des informations d'adressage locales */

        /* 4.1. Mise à jour du domaine de la socket locale */

        infosAddrLoc.sin_family=AF_INET;

        /* 4.2. Mise à jour du numéro de port local après avoir fait la conversion en format réseau */

        infosAddrLoc.sin_port=htons(1234);

        infosAddrLoc.sin_addr.s_addr = htonl(INADDR_ANY);  /* 4.3. Que fait-on ici  ? */  
        /* …..... */

        /* 4.4. Mise à jour de tailleInfosAddrLoc */
         tailleInfosAddrLoc = sizeof(infosAddrLoc);

        /* 5. Attachement de la socket locale, si erreur on quitte le programme */ 
        if(bind(sock,(struct sockaddr *) &infosAddrLoc, tailleInfosAddrLoc) == -1){
            printf("BIND RETURN -1\n");
            printf("MESSAGE : %s\n",strerror(errno));

        }else printf("TUTTI VA BENE\n");
        /* 6. Récupère les informations du serveur à partir de son nom */
         infosServ = gethostbyname(nomServ);    

        /* 7. Mise à jour des informations d'adressage du serveur */
         infosAddrServ.sin_family = AF_INET;	/* Mise à jour du domaine de la socket serveur */
         infosAddrServ.sin_port = htons(portServ);            /* Mise à jour du numéro de port serveur */
         memcpy(&infosAddrServ.sin_addr, infosServ->h_addr, infosServ->h_length);	/*Mise à jour de l'adresse IP du serveur*/
  
         printf("Adresse du serveur: %s \n", inet_ntoa(infosAddrServ.sin_addr));
  
         tailleInfosAddrServ = sizeof(infosAddrServ);	/* Mise à jour de tailleInfosAddrServ */
  
        /* 8. Connexion au serveur, si problème de connexion on quitte le programme */
        /*if(connect(sock, (struct sockaddr *) &infosAddrServ, tailleInfosAddrServ) == -1){
            printf("CONNECT RETURN -1\n");
            printf("MESSAGE : %s\n",strerror(errno));
        }else printf("TUTTI VA BENE +\n");
        */

         // MODE SERVEUR 

        if(listen (sock, 50) == -1){
            printf("Listen RETURN -1\n");
            printf("MESSAGE : %s\n",strerror(errno));
        }else printf("TUTTI VA BENE +\n");
        int new_fd;
        if((new_fd = accept(sock,(struct sockaddr *) &infosAddrServ, &tailleInfosAddrLoc)) == -1){
            printf("accept RETURN -1\n");
            printf("MESSAGE : %s\n",strerror(errno));
        }else printf("TUTTI VA BENE +\n");

        /* 10. Récupère la réponse du serveur et l'affiche */

        if(recv(new_fd,msgRecu, sizeof(msgRecu), 0) == -1){
            printf("recv RETURN -1\n");
            printf("MESSAGE : %s\n",strerror(errno));
        }else{
            // MESSAGE RECU EN MAJUSCULE
            char mot[1000];
            for (int i=0; i<strlen(msgRecu); i++) {
                 mot[i]=toupper(msgRecu[i]);
            }
            printf("%s\n",mot);
        } 

        /* 11. Fermeture de la socket */
        close(sockLoc) ;
}