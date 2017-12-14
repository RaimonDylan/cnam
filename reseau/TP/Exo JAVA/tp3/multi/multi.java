import java.rmi.*;
import java.net.*;
import java.rmi.registry.*;
import java.rmi.server.*;
import java.util.*;

interface CalculateurInterface extends Remote{
    public float donneTauxActuel() throws RemoteException;
}

class Calculateur extends UnicastRemoteObject implements CalculateurInterface{
    float taux = 0.0F;
    public Calculateur () throws RemoteException {
        super(); 
    }

    public void majTauxActuel(float taux) throws RemoteException {
        this.taux=taux;
    }

    public float donneTauxActuel() throws RemoteException {
        return taux;       
    }
}

class SaisieEtMajTaux extends Thread {
    private Calculateur calculateur;
    private String url;

    public SaisieEtMajTaux (String url, Calculateur calculateur){
        this.url=url;
        this.calculateur=calculateur;
    }

    public void run() {

        // Demande à l'utilisateur de saisir son message au clavier
        while(true){
            float taux=0.0F;
            Scanner keyboard = new Scanner(System.in);
            System.out.print ("Nouveau taux : ");
            String s=keyboard.nextLine();

            try{
                taux = Float.parseFloat(s);
            }
            catch (Exception e) {
                System.out.println ("Valeur entiere ou reelle SVP ");
            }
            try{
                calculateur.majTauxActuel(taux);
                // Naming.rebind(url, calculateur);
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

class ServeurTaux {
    public static void main(String[] args) {
        try {

            LocateRegistry.createRegistry(1099);

            Calculateur calculateur = new Calculateur();
            String url="rmi://"+InetAddress.getLocalHost().getHostAddress()+"/calculateur";

            SaisieEtMajTaux saisieEtMajTaux=new SaisieEtMajTaux(url, calculateur) ;
            saisieEtMajTaux.start();

            Naming.rebind(url, calculateur);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}

class AccesDistant extends Thread {

    private Global global;
    private String nom;

    public AccesDistant(Global global, String nom){
        this.global=global;
        this.nom=nom ;
    }

    public void run(){
        try {
		
            CalculateurInterface calculateur = (CalculateurInterface)Naming.lookup("rmi://localhost:1099/calculateur"); 

            float tauxActuelDistant=calculateur.donneTauxActuel();

            global.majTauxActuel (tauxActuelDistant); 

        }
        catch (Exception e){
            e.printStackTrace() ;
        }
    }
}
class Global {

    private float tauxActuel = 0.0F;	 
    private float tauxPrecedent = -1.0F;

    public float lectureTauxActuel(){ 
        return tauxActuel;
    }

    public float lectureTauxPrecedent(){         
        return tauxPrecedent;
    }

    public float[] lectureTauxActuelEtPrecedent(){
        float tab[]= new float[2];
        tab[0] = tauxActuel;
        tab[1] = tauxPrecedent;
        return tab;
    }

    public void majTauxActuel (float nouveauTaux){
        if (nouveauTaux != tauxActuel){
            tauxPrecedent= tauxActuel;
            tauxActuel = nouveauTaux;

            System.out.println("Nouvelle mise a jour du taux : "+tauxActuel);
        }
    }
}

class TraitementLocal extends Thread {

    private Global global;
    private String nom ;
    private AccesDistant accesDistant;

    public TraitementLocal (Global global, String nom, AccesDistant accesDistant){
        this.global=global;
        this.nom=nom ;
        this.accesDistant= accesDistant;
    }

    public void run(){
        try {

                // Première partie du traitement n’ayant pas besoin du taux de reference (celle du site distant)
                System.out.println("Debut d'un traitement, je n'ai pas besoin du taux de reference");

                float taux =global.lectureTauxActuel();    // Récupération du taux

                // Deuxieme partie du traitement utilisant le taux récupéré sur le site distant
                System.out.println("A partir d'ici, je dois poursuivre avec le taux actualise,  taux : "+taux);
                System.out.println("Ca y est, j'ai fini mon traitement");

        } 
        catch (Exception e){
            e.printStackTrace();
        }
    }
}

class ClientTaux{
    public static void main(String args[]){
        Global global=new Global();
        AccesDistant accesDistant = new AccesDistant (global, "Distant");
        TraitementLocal traitementLocal = new TraitementLocal (global, "Local", accesDistant);
        accesDistant.start();
        traitementLocal.start();
    }
}



