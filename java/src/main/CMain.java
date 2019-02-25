package main;

import javax.swing.JFrame;

import meute.OceanJPanel;

public class CMain {
    public static void main(String[] args) {
        // Création de la fenêtre.
    	JFrame myFrame = new JFrame();
    	myFrame.setTitle("Banc de poissons");
    	myFrame.setSize(1000,600);
    	myFrame.setLocationRelativeTo(null);
    	myFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    	myFrame.setResizable(false);
    	
    	
        // Création du contenu
        OceanJPanel panel = new OceanJPanel();
        myFrame.setContentPane(panel);
        
        // Affichage
    	myFrame.setVisible(true);
        
        // Lancement du processus.
    	panel.Lancer();
    }
}
