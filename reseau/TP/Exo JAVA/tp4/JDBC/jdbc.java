import java.sql.*;

public class Test{

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        try {

            String DBurl ="";

            /* Exemple avec SGBD MySql local 
            Class.forName("com.mysql.jdbc.Driver");
            DBurl="jdbc:mysql://localhost:3306/BDTEST";
            */

            /* Exemple avec SGBD PostgreSQL local
            Class.forName("org.postgresql.Driver");
            DBurl="jdbc:postgresql://localhost:3306/BDTEST";
            */

            /* Exemple avec Microsoft Access en local */
            String path="C:/MaBase.mdb";
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            DBurl="jdbc:odbc:DRIVER={Microsoft Access Driver (*.mdb)};DBQ="+path;

            /* Connexion avec un login et un password factices
            String user = "user";
            String password = "pass";
            Connection con = DriverManager.getConnection(DBurl, user, password); */

            Connection con = DriverManager.getConnection(DBurl); 

            Statement stmt = con.createStatement(); // pour exécution d'une requête SQL
            String requete=""; // requête SQL
            ResultSet rset = null; // pour contenir le résultat d'une requête SQL de type SELECT

            ResultSetMetaData rsmd = null; // pour les métadonnées d'un ResultSet (question 3)
            String ligneAffichage=""; // ligne d'un ResultSet (formatée de telle ou telle façon) pour affichage console (question 3)
            int nbColonnes=-1; // pour le nombre de colonnes d'un ResultSet (question 3)

            int nbRes=-1; // pour le nombre de mises à jour de la requête SQL de type UPDATE de la question 4

            ResultSet rset2 = null; // pour besoin d'un deuxième ResultSet (questions 5 et 6)
            float compteToto=-1.0f; // pour la valeur du compte de toto (questions 5 et 6)
            float compteTiti=-1.0f; // pour la valeur du compte de titi (questions 5 et 6)
            PreparedStatement pstmt=null; // pour exécution requête SQL paramétrée (question 6)

            int nbMaj=-1; // pour le nombre de mises à jour des deux requêtes SQL de type UPDATE de la question 7


            /* 1. Question 1. */

            try{
                  /* 1.1. Requête SQL */
                  String requete = "SELECT nom,prenom,age,compte FROM client";
                  /* 1.2. Exécution de la requête */
                  Statement stmt = con.createStatement();
                  ResultSet resultats = stmt.executeQuery(requete);
                  /* 1.3. Parcours et affichage de chaque ligne */ 
                  System.out.println("nom  \t"+"prénom  \t "+"age  \t" +"compte" );
                  while (resultats.next()){
                        System.out.println(resultats.getString("nom")+" "+resultats.getString("prenom")+" "+resultats.getInt("age")+" "+resultats.getFloat("compte"));
            }
            catch(SQLException e){

            }
            


            /* 2. Question 2. */

            /* 2.1. Variables pour contenir la somme de tous comptes et le nombre de comptes non null */
            float sommeComptes=0.0f;
            int nbComptesNotNull=0 ;

            /* 2.2. On repositionne le curseur sur la première ligne de résultat */
            resultats.first();

            /* 2.3. Parcours de chaque ligne en mettant à jour les deux variables précédentes */
            while (resultats.next()){
                  
            }

            /* 2.4. Affichage du résultat */
            System.out.println("Somme des comptes: "+sommeComptes+" Nombre de comptes valides: "+nbComptesNotNull);

                
            /* 3. Question 3. */

            /* 3.1. Requête SQL et exécution de celle-ci */
            …......
            …......

            /* 3.2. Récupérer le nombre de colonnes du résultat */
            …......
            …......

            /* 3.3. Afficher le nom des colonnes sur une ligne */ 
            …......
            …......
            …......

            /* 3.4. Parcours et affichage de chaque ligne */
            …......
            …......
            …......
            …......
            …......
            …......

            /* 4. Question 4. */

           /* 4.1 Requête de mise à jour */
            requete= "update personnes set age=age+1 where age >100";

            /* 4.2. Exécution de la requête et annulation de celle-ci si le nombre de personnes concernés par la mise à jour est    
            supérieur à 1*/
            …......
            …......
            …......
            …......
            …......
            …......


            /* 5. Question 5. */

            con.setAutoCommit(false);

            /* 5.1. Requêtes pour récupérer le compte de "toto" et le compte de "titi" ; remarque : SELECT FOR 
UPDATE :    
            verrouillage "Row Share Table Locks (RS)" sur une une BD Oracle */

            requete="select compte from personnes where nom = 'toto' for update of personnes";
            rset = stmt.executeQuery(requete);
            requete="select compte from personnes where nom = 'titi' for update of personnes";
            rset2 = stmt.executeQuery(requete);

            /* 5.2. Si les personnes "toto" ou "titi" n'existent pas, on annule la transaction  */
            …......
            …......

            else {

                /* 5.3. Récupération des comptes ; si l'un d'eux n'est pas renseigné (null), on annule la transaction  */
                …......
                …......
                …......
                …......
                  
                else{

                    /* 5.4. Ecrire, exécuter et valider les deux requêtes de mise à jour */
                    …......
                    …......
                    …......
                    …......
                    …......

                    /* Remarque : une autre manière de faire aurait été de mettre à jour les lignes directement dans le ResultSet 
          => ligne correspondant à la personne "toto"
                    rset.updateFloat("compte", compteTiti);
                    rset.updateRow();
                    => ligne correspondant à la personne "titi"
                    rset2.updateFloat("compte", compteToto);
                    rset2.updateRow();
                    con.commit(); */ 

                }
            }

        } 
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}


