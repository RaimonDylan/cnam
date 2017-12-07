#include <rpc/rpc.h>
#include <stdio.h>
#include <stdlib>
#include <string.h>
#include <strings.h>

#define ARITHM_PROG_NUM ((u_long)0x33333333)
#define ARITHM_VERS_NUM ((u_long)1)
#define ADD_FCT_NUM ((u_long)1)

/* Deux entiers pour le calcul */
struct operands{
    int op1;
    int op2;
};

/* Fonction d'/de… */
bool_t encoding_operands(XDR *x, struct operands *ops){
    /* Même chose que pour serveur.c */ 
    ….....
}

/* Fonction principale. argv[1] : hôte distant. argv[2] : première opérande. argv[3] : deuxième opérande. */

main(int argc, char *argv[]){

    if (argc<4){
        fprintf(stderr, "missing parameters\n")
        exit(1)
    }

    char *host=argv[1];

    struct operands ops;
    /* Récupération des deux entiers */
    ….....
    ….....

   /* Entier qui contiendra leur somme*/
    int result;

    /* Appel de la fonction distante */
    ….....

    if (r!=0){
        clnt_perrno(r);
        exit(1);
    }

    printf("La somme de %d et %d est : %d\n", ops.op1, ops.op2, result);
    exit(0);

}
