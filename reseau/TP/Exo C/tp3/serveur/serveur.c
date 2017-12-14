#include <rpc/rpc.h>
#include <rpc/xdr.h>
#include <rpc/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <rpc/pmap_clnt.h>

#define ARITHM_PROG_NUM ((u_long)0x33333333)
#define ARITHM_VERS_NUM ((u_long)1)
#define ADD_FCT_NUM ((u_long)1)

/* Deux entiers pour le calcul */
struct operands{
    int op1;
    int op2;
};

/* Fonction d'/de … */
bool_t encoding_operands(XDR *x, struct operands *ops){
    if(ops != NULL){
        xdr_int(x, &(ops->op1));
        xdr_int(x, &(ops->op2));
    } else return -1;
}

/* Fonction appelable à distance qui calcule la somme de 2 entiers */
int *add (struct operands *ops){
    int result = ops->op1 + ops->op2;
    return result;
}

/*  */
void main(int argc, char *argv[]){

    pmap_unset(ARITHM_PROG_NUM, ARITHM_VERS_NUM);

    /* Enregistrement de la fonction auprès du portmap */
   // Pointeur de fonction juste avec le nom de fonction
    int r = registerrpc(ARITHM_PROG_NUM, ARITHM_VERS_NUM, ADD_FCT_NUM, add, encoding_operands,xdr_int);

    if (r==-1){
        perror("Registering service\n");
        exit(1);
    }
    svc_run();
    exit(0);
}
