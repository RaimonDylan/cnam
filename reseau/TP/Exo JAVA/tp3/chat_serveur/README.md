# Serveur du Chat
```java
import java.rmi.*;
import java.rmi.server.*;
import java.net.*;
import java.util.*;

interface ServeurTchatInterface extends Remote{
    public void enregistrementClient(ClientTchatInterface client) throws RemoteException;
    public void desenregistrementClient(ClientTchatInterface client) throws RemoteException;
    public int nbClientsEnCours() throws RemoteException;
    public void transfertMessage(String msg) throws RemoteException;
}

interface ClientTchatInterface extends Remote{
    public void recuperationNouveauMessage(String msg) throws RemoteException;
}



class ServeurTchat extends UnicastRemoteObject implements ServeurTchatInterface{

    Vector<ClientTchatInterface> clients=new Vector<ClientTchatInterface>();

    public ServeurTchat () throws RemoteException {
        super();
    }

     /* en-tête de la méthode enregistrementClient(...) */
    public void enregistrementClient(ClientTchatInterface client) throws RemoteException{
        clients.add(client);
    }
    

     /* en-tête de la méthode desenregistrementClient(...) */
     public void desenregistrementClient(ClientTchatInterface client) throws RemoteException{
        for (int i=0; i<clients.size(); i++)
            if (client.equals((ClientTchatInterface)(clients.get(i))))
                clients.removeElementAt(i);
    }

    /* retourne le nombre de clients en cours */
    public int nbClientsEnCours() throws RemoteException {
        return clients.size();
    }

    /* En-tête de la méthode transfertMessage(...) */
    public void transfertMessage(String msg) throws RemoteException{
            for (int i=0; i<clients.size(); i++){
            	ClientTchatInterface client= (ClientTchatInterface)(clients.get(i));
            	client.recuperationNouveauMessage(msg);
        	}

    }

    public static void main(String[] args) {
        try {

            java.rmi.registry.LocateRegistry.createRegistry(1099);
            ServeurTchat serveurTchat = new ServeurTchat();
            String url="rmi://"+InetAddress.getLocalHost().getHostAddress()+"/tchat";
            /* On enregistre dans la rmiregistry un objet de la classe courante */ 
            Naming.rebind(url, serveurTchat);            
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```
