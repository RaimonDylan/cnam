class Etudiant extends Personne {

      int numEtudiant;
      String nomUniversite;

      public Etudiant (String nom, String prenom, int age, int numEtudiant, String nomUniversite){
            super
      }

      public void afficheInformations(){
            System.out.println("Je suis l'etudiant "+retournerNom()+" "+retournerPrenom()+ " d'age "+retournerAge()+" ans identifie par "+numEtudiant+" et etudiant a "+nomUniversite);
      }
}
