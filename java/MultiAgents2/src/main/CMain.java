package main;

import javax.swing.JFrame;

import meute.OceanJPanel;

public class CMain {
    public static void main(String[] args) {
        // Création de la fenêtre
        JFrame fenetre = new JFrame();
        fenetre.setTitle("Banc de poissons");
        fenetre.setSize(1300, 700);
        fenetre.setLocationRelativeTo(null);
        fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        fenetre.setResizable(false);
        
        // Création du contenu
        OceanJPanel panel = new OceanJPanel();
        fenetre.setContentPane(panel);
        
        // Affichage
        fenetre.setVisible(true);
        panel.Lancer();
    }
}
