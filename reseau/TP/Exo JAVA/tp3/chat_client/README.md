# Client du Chat
```java
import java.rmi.*;
import java.rmi.server.*;
import java.util.*;

import java.rmi.*;

interface ServeurTchatInterface extends Remote{
    public void enregistrementClient(ClientTchatInterface client) throws RemoteException;
    public void desenregistrementClient(ClientTchatInterface client) throws RemoteException;
    public int nbClientsEnCours() throws RemoteException;
    public void transfertMessage(String msg) throws RemoteException;
}

interface ClientTchatInterface extends Remote{
       public void recuperationNouveauMessage(String msg) throws RemoteException;
}

class ClientTchat extends UnicastRemoteObject implements ClientTchatInterface  {

    public ClientTchat()throws RemoteException{
        super();
    }

    /* Méthode recuperationNouveauMessage(...)  qui affiche un message reçu depuis le serveur */
    public void recuperationNouveauMessage(String msg){
        System.out.println(msg);
    }

    public static void main(String args[]){
        try {

            if (args.length<2){
                System.out.println("Nom d'hôte puis pseudo en ligne de commande SVP");
                return;
            }
            String nom_hote=args[0];
            String pseudo=args[1];

            ServeurTchatInterface serveurTchatInterface = (ServeurTchatInterface)Naming.lookup("rmi://"+nom_hote+":1099/tchat"); 
          
            /* Création d'un objet de la classe courante et enregistrement de celui-ci auprès du serveur */  
            ClientTchatInterface leClient = new ClientTchat(); 
            serveurTchatInterface.enregistrementClient(leClient);

            System.out.println (serveurTchatInterface.nbClientsEnCours());
            System.out.println ("Discussion (-1 pour la quitter) : ");
            while(true){
                Scanner keyboard = new Scanner(System.in);
                String s=keyboard.nextLine();
                if(s.equals("-1")){
                    serveurTchatInterface.desenregistrementClient(leClient);
                    System.exit(0);
                }
                String message = pseudo+" : "+s;
                serveurTchatInterface.transfertMessage(message);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```
