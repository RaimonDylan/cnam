package meute;

import java.util.ArrayList;
import java.util.Observable;
import java.util.Random;

// L'oc√©an dans lequel nagent les poissons
public class Ocean extends Observable {
	public static final int NB_POISSONS = 1500;
	public static final int NB_OBSTACLES = 50;

    // Attributs
    protected Poisson[] poissons;
    protected ArrayList<ZoneAEviter> obstacles;
    protected static Random generateur;
    protected double largeur;
    protected double hauteur;
    
    // MÈthodes
    public Ocean(int _nbPoissons, double _largeur, double _hauteur) {
        largeur = _largeur;
        hauteur = _hauteur;
        generateur = new Random();
        obstacles = new ArrayList();        
        poissons = new Poisson[_nbPoissons];
        for (int i = 0; i < _nbPoissons; i++) {
            poissons[i] = new Poisson(
            		generateur.nextDouble() * largeur,
            		generateur.nextDouble() * hauteur,
            		generateur.nextDouble() * 2 * Math.PI,
            		(int)(generateur.nextDouble() * Poisson.LONGUEUR_INITIALE) + 0.3*Poisson.LONGUEUR_INITIALE,
            		(int)(generateur.nextDouble() * Poisson.NB_FAMILLES));
        }
    }
    
    public void AjouterObstacle(double _posX, double _posY, double rayon) {
        obstacles.add(new ZoneAEviter(_posX, _posY, rayon));
    }
    
    protected void MiseAJourObstacles() {
        for(ZoneAEviter obstacle : obstacles) {
            obstacle.MiseAJour();
        }
        obstacles.removeIf(o -> o.estMort());
    }
    
    protected void MiseAJourPoissons() {
        for (Poisson p : poissons) {
            p.MiseAJour(poissons, obstacles, largeur, hauteur);
            CalculerNombreVoisins(p, poissons);
        }
    }
    
    public void MiseAJourOcean() {
        MiseAJourObstacles();
        MiseAJourPoissons();
        setChanged();
        notifyObservers();
    }
    
    public void CalculerNombreVoisins(Poisson poisson, Poisson[] banc) {
    	poisson.nbVoisins = 0;
        for (Poisson p : poissons) {
        	if (poisson.famille == p.famille) {
	            double d = (p.posX - poisson.posX) * (p.posX - poisson.posX) 
	            		+ (p.posY - poisson.posY) * (p.posY - poisson.posY);
	
	            
	            if (d < Poisson.VOISINAGE_CARRE) {
	            	poisson.nbVoisins++;
	            }
        	}
        }
    }
    
    public void selectionnePoisson(int x, int y) {
        for (Poisson p : poissons) {
        	p.selectionneSiPossible(x, y);
        }
    }
    
}
