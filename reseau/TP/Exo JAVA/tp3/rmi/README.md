# RMI
```java
import java.rmi.*;
import java.io.*;
import java.rmi.server.*;

interface TraitementsInterface extends Remote{
    public void vieillirPersonne(Personne p) throws RemoteException;
}


class PetitClient{ 
    public static void main(String args[]){
        try {

            if (args.length<1){
                System.out.println("Nom d'hôte SVP");
                return;
            }
            String nom_hote=args[0];

            Personne p=new Personne ("Lucky", "Luke", 30);

            TraitementsInterface traitementsInterface =(TraitementsInterface)Naming.lookup("rmi://"+nom_hote+":1099/traitements"); 
            traitementsInterface.vieillirPersonne(p);

            p.afficherAge();

        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}


class Personne implements Serializable{
    private String nom;
    private String prenom;
    private int age;
    
    public Personne(String nom, String prenom, int age){
        this.nom=nom;
        this.prenom=prenom;
        this.age=age;
    }

    public void vieillir(){
        age++;
    }

    public void afficherAge(){
        System.out.println(prenom+" "+nom+" a "+age+ "ans");
    }
}



class Traitements extends UnicastRemoteObject implements TraitementsInterface{

    public Traitements () throws RemoteException{
        super(); // constructeur de la classe mère
    }

    public void vieillirPersonne(Personne p) throws RemoteException {
        p.vieillir();
    }
}



```
