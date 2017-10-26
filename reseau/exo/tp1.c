#include <stdio.h> //printf
#include <string.h> //memset
#include <stdlib.h> //for exit(0);
#include <sys/socket.h>
#include <errno.h> //For errno - the error number
#include <netdb.h> //hostent
#include <arpa/inet.h>


int main(int argc , char *argv[]) {
    
    char str1[20];

    printf("Host name : ");
    scanf("%s", str1);   
    struct hostent *hp = gethostbyname(str1);   
    if(hp == NULL) printf("\nFAIL\n");
    else{
        printf("%s = ", hp->h_name);
        int i = 0;
        while(hp->h_addr_list[i] != NULL){
            printf("%s \n", inet_ntoa(*(struct in_addr*)(hp->h_addr_list[i])));
            i++;
        }       
    }
    return 0;
}
