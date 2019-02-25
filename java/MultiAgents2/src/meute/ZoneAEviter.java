package meute;

// Une zone Ã  éviter pour les poissons. Celle-ci disparait automatiquement au bout d'un moment
public class ZoneAEviter extends CObject {
    protected double rayon;
    protected int tempsRestant = 500;
    
    public ZoneAEviter(double _x, double _y, double _rayon) {
        posX = _x;
        posY = _y;
        rayon = _rayon;
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
