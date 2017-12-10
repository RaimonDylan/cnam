import java.rmi.*;
import java.io.*;
import java.rmi.server.*;
import java.net.*;
import java.rmi.registry.*;

interface TraitementsInterface extends Remote{
    public void vieillirPersonne(PersonneInterface p) throws RemoteException;
}


class PetitServeur {
    public static void main(String[] args){
        try {

            LocateRegistry.createRegistry(1099);

            Traitements traitements= new Traitements();
            String url="rmi://"+InetAddress.getLocalHost().getHostAddress()+"/traitements";

            Naming.rebind(url, traitements);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}






class Traitements extends UnicastRemoteObject implements TraitementsInterface{

    public Traitements () throws RemoteException{
        super(); // constructeur de la classe mère
    }

    public void vieillirPersonne(PersonneInterface p) throws RemoteException {
        p.vieillir();
    }
}


