import java.rmi.*;
import java.io.*;
import java.rmi.server.*;
import java.net.*;
import java.rmi.registry.*;

interface TraitementsInterface extends Remote{
    public void vieillirPersonne(PersonneInterface p) throws RemoteException;
}

interface PersonneInterface extends Remote{
    public void vieillir() throws RemoteException;
    public void afficherAge() throws RemoteException;
}


class PetitClient{ 
    public static void main(String args[]){
        try {

            if (args.length<1){
                System.out.println("Nom d'hôte SVP");
                return;
            }
            String nom_hote=args[0];

            PersonneInterface p=new Personne ("Lucky", "Luke", 30);

            

            TraitementsInterface traitementsInterface =(TraitementsInterface)Naming.lookup("rmi://localhost:1099/traitements"); 
            traitementsInterface.vieillirPersonne(p);

            p.afficherAge();

        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}


class Personne extends UnicastRemoteObject implements PersonneInterface{
    private String nom;
    private String prenom;
    private int age;
    
    public Personne(String nom, String prenom, int age) throws RemoteException{
        this.nom=nom;
        this.prenom=prenom;
        this.age=age;
    }

    public void vieillir() throws RemoteException{
        age++;
    }

    public void afficherAge() throws RemoteException{
        System.out.println(prenom+" "+nom+" a "+age+ "ans");
    }
}





