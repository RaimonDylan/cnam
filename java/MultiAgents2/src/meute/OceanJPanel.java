package meute;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.Observable;
import java.util.Observer;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;

import javax.swing.JPanel;

// L'affichage de notre simulation
public class OceanJPanel extends JPanel implements Observer, MouseListener {
    protected Ocean ocean;
    protected Timer timer;
    protected Random generateur;

    
    public OceanJPanel() {
        generateur = new Random();
        //this.setBackground(new Color(150, 255, 255));
        this.addMouseListener(this);
    }
    
    public void Lancer() {
        ocean = new Ocean(Ocean.NB_POISSONS, this.getWidth(), getHeight());
        ocean.addObserver(this);
        
        for(int i = 0; i < Ocean.NB_OBSTACLES; i++) {
        	ocean.AjouterObstacle(
        			generateur.nextDouble()*1680,
        			generateur.nextDouble()*1000,
        			10/*generateur.nextDouble()*20*/);
        }

        
        TimerTask tache = new TimerTask() {
            @Override
            public void run() {
                ocean.MiseAJourOcean();
            }
        };
        timer = new Timer();
        timer.scheduleAtFixedRate(tache, 0, 1);
    }

    protected void DessinerPoisson(Poisson p, Graphics g) {
    	if (p.energie > 0) {
	    	int cr = 0;
	    	int cv = 0;
	    	int cb = 0;
	    	
	    	
	    	if (p.famille == 0) {
	        	cr = 128;//(p.nbVoisins >= 255) ? 255 : p.nbVoisins;
	        	cv = 0;
	        	cb = 0;
	    	} else if (p.famille == 1) {
	        	cr = 0;
	        	cv = 128;//(p.nbVoisins >= 255) ? 255 : p.nbVoisins;
	        	cb = 0;
	    	} else if (p.famille == 2) {
	        	cr = 0;
	        	cv = 0;
	        	cb = 128;//(p.nbVoisins >= 255) ? 255 : p.nbVoisins;
	    	}
	    	
	    	g.setColor(new Color(cr, cv, cb));
	        g.drawLine(
	        		(int) p.posX,
	        		(int) p.posY,
	        		(int) (p.posX - p.longueur * (p.energie/100.0) * p.vitesseX),
	        		(int) (p.posY - p.longueur * (p.energie/100.0) * p.vitesseY));
	        g.fillArc(
	        		(int) p.posX-4,
	        		(int) p.posY-4,
	        		8, 8, 0, 360);
	        
	        if (p.estSelectionne) {
	        	g.setColor(Color.BLACK);
		        g.drawArc(
		        		(int) p.posX-30,
		        		(int) p.posY-30,
		        		60, 60, 0, 360);
		        System.out.println(p);
	        }
	//        if (p.nbVoisins < Ocean.NB_POISSONS/10) {
	//        	g.setColor(new Color(cr, cv, cb));
	//            g.drawArc(
	//            		(int) p.posX-25,
	//            		(int) p.posY-25,
	//            		50, 50, 0, 360);
	//            if (p.longueur < Poisson.LONGUEUR_MAXIMALE) {
	//            	p.longueur++;
	//            } else if (p.longueur > Poisson.LONGUEUR_INITIALE) {
	//        	    p.longueur--;
	//            }
	//        } 
    	}
    }
    
    protected void DessinerObstacle(ZoneAEviter o, Graphics g) {
    	g.setColor(Color.black);
        g.fillOval((int) (o.posX - o.rayon), (int) (o.posY - o.rayon), (int) o.rayon * 2, (int) o.rayon * 2);
    }
    
    @Override
    public void update(Observable o, Object arg) {
        this.repaint();
    }
    
    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        for (Poisson p : ocean.poissons) {
            DessinerPoisson(p, g);
        }
        for (ZoneAEviter o : ocean.obstacles) {
            DessinerObstacle(o, g);
        }
    }

    @Override
    public void mouseClicked(MouseEvent e) {
    	// Sur clique gauche : pose d'un obstacle.
    	if (e.getButton() == MouseEvent.BUTTON1) {
    		ocean.AjouterObstacle(e.getX(), e.getY(), 10);
    	}
    	// Sur clique droit, obtention des informations de l'agent cliqué.
    	// Ces informations s'affichent dans la console.
    	else if (e.getButton() == MouseEvent.BUTTON3) {
    		// Parcours de l'ensemble des poissons et sélection de celui
    		// dont la position est proche de celle du curseur de la souris. 
    		ocean.selectionnePoisson(e.getX(), e.getY());
    	}
    }

    @Override
    public void mousePressed(MouseEvent e) {}
    @Override
    public void mouseReleased(MouseEvent e) {}
    @Override
    public void mouseEntered(MouseEvent e) {}
    @Override
    public void mouseExited(MouseEvent e) {}
}
