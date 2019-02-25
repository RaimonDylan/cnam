package meute;

import java.awt.Color;
import java.util.ArrayList;
import java.util.Random;

// Un poisson, généré par un agent
public class Poisson extends CObject {
    // Constantes
	public static final int NB_FAMILLES = 3;
    public static final double PAS = 3;
    public static final double DISTANCE_MIN = 5;
    public static final double DISTANCE_MIN_CARRE = 25;
    public static final double DISTANCE_COMBAT_MIN_CAREE = 200;
    public static final double DISTANCE_MAX = 40;
    public static final double DISTANCE_MAX_CARRE = 1600;

    public static final double VOISINAGE = 100;
    public static final double VOISINAGE_CARRE = 10000;

    public static final double LONGUEUR_INITIALE = 15;
    public static final double LONGUEUR_MAXIMALE = 50;
    
    
    // Attributs
    // Vitesse et nombre de voisins.
    protected double vitesseX;
    protected double vitesseY;
    protected double nbVoisins;
    protected int familles;
    public Color color;
    private Random generateur; 
    public int energie;
    public boolean selected;
    
   
    
    // MÃ©thodes
    public Poisson(double posX, double posY, double dir, double longueur, int familles) {
    	this.posX = posX;
    	this.posY = posY;
    	this.longueur = longueur;
    	this.vitesseX = Math.cos(dir);
    	this.vitesseY = Math.sin(dir);
    	this.nbVoisins = 0;
    	generateur = new Random();
    	this.familles = familles;
    	this.energie = 100;
    	this.selected = false;
    }
    
    // Getters
	public double getVitesseX() {
		return this.vitesseX;
	}
	
	public double getVitesseY() {
		return this.vitesseY;
	}
	
    protected void MiseAJourPosition() {
    	this.posX += PAS * vitesseX;
    	this.posY += PAS * vitesseY;
    }
    
    protected boolean DansAlignement(Poisson p) {
    	double d = DistanceCarre(p);
    	return (d < DISTANCE_MAX_CARRE && d > DISTANCE_MIN_CARRE);
    }
    
    protected double DistanceAuMur(double murXMin, double murYMin, double murXMax, double murYMax) {
    	double min = Math.min(posX - murXMin, posY - murYMin);
    	min = Math.min(min, murXMax- posX);
    	min = Math.min(min, murYMax - posY);
    	return min;
    }
    
    protected void Normaliser() {
    	double longueur = Math.sqrt(vitesseX * vitesseX + vitesseY * vitesseY);
    	vitesseX /= longueur;
    	vitesseY /= longueur;
    }
    
    protected boolean EviterMurs(double murXMin, double murYMin, double murXMax, double murYMax) {
        // On s'arrête aux murs
    	if(posX < murXMin)
    		posX = murXMin;
    	else if(posY < murYMin)
    		posY = murYMin;
    	else if(posX > murXMax)
    		posX = murXMax;
    	else if(posY > murYMax)
    		posY = murYMax;
        
        // Changer de direction
    	double distance = DistanceAuMur(murXMin, murYMin, murXMax, murYMax);
    	if(distance < DISTANCE_MIN) {
    		if(distance == (posX - murXMin))
    			vitesseX += 0.3;
    		else if(distance == (posY - murYMin))
    			vitesseY += 0.3;
    		else if(distance == (murXMax - posX))
    			vitesseX -= 0.3;
    		else if(distance == (murYMax - posY))
    			vitesseY -= 0.3;
    		Normaliser();
    		return true;
    	}
    	return false;
    }
    
    protected boolean EviterObstacles(ArrayList<ZoneAEviter> obstacles) {
    	if(!obstacles.isEmpty()) {
    		ZoneAEviter obstacleProche = obstacles.get(0);
    		double d = DistanceCarre(obstacleProche);
    		for (ZoneAEviter o : obstacles) {
    			if(DistanceCarre(o) < d) {
    				obstacleProche = o;
    				d = DistanceCarre(o);
    			}
    		}
    		
    		if( d < (obstacleProche.rayon * obstacleProche.rayon)) {
    			double distance = Math.sqrt(d);
    			double diffX = (obstacleProche.posX - posX) / distance;
    			double diffY = (obstacleProche.posY - posY) / distance;
    			vitesseX = vitesseX - diffX / 2;
    			vitesseY = vitesseY - diffY / 2;
    			Normaliser();
    			return true;
    		}
    	}
    	return false;
    }
    
    protected boolean EviterPoissons(Poisson[] poissons) {
    	Poisson p;
    	if(!poissons[0].equals(this)) {
    		p = poissons[0];
    	}
    	else {
    		p = poissons[1];
    	}
		double d = DistanceCarre(p);
		for (Poisson poisson : poissons) {
			if(DistanceCarre(poisson) < d && !poisson.equals(this) && p.familles == this.familles) {
				p = poisson;
				d = DistanceCarre(p);
			}
		}
		
		if(d < DISTANCE_MIN_CARRE) {
			double distance = Math.sqrt(d);
			double diffX = (p.posX - posX) / distance;
			double diffY = (p.posY - posY) / distance;
			vitesseX = vitesseX - diffX / 4;
			vitesseY = vitesseY - diffY / 4;
			Normaliser();
			return true;
		}
		return false;
    }
    
    protected void CalculerDirectionMoyenne(Poisson[] poissons) {
    	double vitesseXTotal = 0;
    	double vitesseYTotal = 0;
    	int nbTotal = 0;
    	for (Poisson p : poissons) {
    		if(DansAlignement(p) && p.familles == this.familles) {
    			vitesseXTotal += p.vitesseX;
    			vitesseYTotal += p.vitesseY;
    			nbTotal++;
    		}
    	}
    	if(nbTotal >= 1) {
    		vitesseX = (vitesseXTotal / nbTotal + vitesseX) / 2;
    		vitesseY = (vitesseYTotal / nbTotal + vitesseY) / 2;
    		Normaliser();
    	}
    }
    
    
    protected void MiseAJour(Poisson[] poissons, ArrayList<ZoneAEviter> obstacles, double largeur, double hauteur) {
    	if(!EviterMurs(0,0,largeur,hauteur)) {
    		if(!EviterObstacles(obstacles)) {
    			if(!EviterPoissons(poissons)) {
    					CalculerDirectionMoyenne(poissons);
    			}
    		}
    	}
    	MiseAJourPosition();
    }
    
    
    public void isSelected() {
    	this.selected = true;
    }
    
    @Override
    public String toString() {
    	return "vitesse X : "+vitesseX+"\nvitesse Y :"+vitesseY;
    }
}
