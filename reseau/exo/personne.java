interface PersonneInterface{
      public void vieillir();
      public void clonerPersonne(Personne p);
}

class Personne implements PersonneInterface{
      private String nom ;
      private String prenom ;
      private int age ;

      public Personne (String nom, String prenom, int age){
            this.nom = nom;
            this.prenom = prenom;
            this.age = age;
      }

      public void vieillir(){
            age++;
      }

      public String retournerNom(){
            return this.nom;
      }

      public String retournerPrenom(){
            return this.prenom;
      }

      public int retournerAge(){
            return this.age;
      }

      public void majNom(String nom){
            this.nom=nom;
      }

      public void majPrenom(String prenom){
            this.prenom=prenom;
      }

      public void majAge(int age){
            this.age=age;
      }

      public void clonerPersonne(Personne p){
            p.nom = this.nom;
            p.prenom = this.prenom;
            p.age = this.age;
      }

      public void afficheInformations(){
            System.out.println("Je suis la personne "+nom+" "+prenom+" et d'age "+age+ " ans");
      }

}

