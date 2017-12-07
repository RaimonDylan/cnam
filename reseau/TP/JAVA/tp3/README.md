# TP3

## II. Java RMI. Passage d'un paramètre objet à une méthode distante par valeur et par adresse

#### a) De quel côté (client ou serveur) doit-on placer ces différentes interfaces et classes (une fois compilées). A quoi correspond chacune ? Que manque t-il et comment l'obtient-t-on ? Qu'est ce qui est affiché par le client ?

  - Client : 
    - TraitementsInterface.java
    - PetitClient.java
    - Personne.java
  - Serveur : 
    - TraitementsInterface.java
    - Traitements.java
    - PetitServeur.java
    - Personne.java
    
Il manque ce traitement :
traitementsInterface.vieillirPersonne(p).
Le serveur exécute bien ce traitement mais modifie la copie de la personne donné en paramètre.
On doit donc passer la personne par référence.

Le client affiche :
```bash
Luke Lucky a 30ans
```
#### b) Que doit-on modifier dans le code des classes et interfaces précédentes pour que le paramètre objet soit maintenant passé par adresse. Comment doit-on maintenant répartir les différentes classes et interfaces entre le client et le serveur.

 - On doit modifier la classe Personne et créer son interface
 
```java
import java.io.*;
import java.rmi.*;
import java.rmi.server.*;
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

```

 - PersonneInterface.java

```java
import java.rmi.*;

interface PersonneInterface extends Remote{
    public void vieillir() throws RemoteException;
    public void afficherAge() throws RemoteException;
}

```

 - Dans le client lui passer un objet de Type : PersonneInterface

```java
PersonneInterface p=new Personne ("Lucky", "Luke", 30);
```
  - On doit donc modifier la methode vieillir Personne de la classe Traitements
  
```java
public void vieillirPersonne(PersonneInterface p) throws RemoteException {
        p.vieillir();
    }
```
  - Donc modifier la signature de cette methode dans son interface
```java
  public void vieillirPersonne(PersonneInterface p) throws RemoteException;
```


Qu'est ce qui est maintenant affiché par le client ?

```bash
Luke Lucky a 31ans
```

## III. Java RMI. Mécanisme du Callback.

#### De quel côté doit-on placer les différentes classes et interfaces ?
  - Client : 
    - ServeurTchatInterface.java
    - ClientTchatInterface.java
    - ClientTchat.java
  - Serveur :
    - ServeurTchatInterface.java
    - ClientTchatInterface.java
    - ServeurTchat.java
