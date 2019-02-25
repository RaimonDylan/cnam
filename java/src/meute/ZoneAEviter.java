package meute;

// Une zone à éviter pour les poissons. Celle-ci disparait automatiquement au bout d'un moment
public class ZoneAEviter extends CObject {
    protected double rayon;
    protected int tempsRestant = 500;
    
    public ZoneAEviter(double posX, double posY, double rayon) {
        this.posX = posX;
        this.posY = posY;
        this.rayon = rayon;
    }
    
    public double getRayon() {
        return rayon;
    }
    
    public void MiseAJour() {
        tempsRestant--;
    }
    
    public boolean estMort() {
        return tempsRestant <= 0;
    }
}
