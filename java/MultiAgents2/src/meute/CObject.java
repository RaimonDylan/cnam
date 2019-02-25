package meute;

// Objet dans le monde (obstacle ou poisson)
public class CObject {
	// ATTENTION : les attributs sont volontairement "public" afin
	// de ne pas dégrader les performances globales à l'exécution.
    public double posX;
    public double posY;
    public double longueur;
    
    
    public CObject() {}

    public CObject(double _x, double _y, double _longueur) {
        posX = _x;
        posY = _y;
        longueur = _longueur;
    }
    
    public double Distance(CObject o) {
    	return Math.sqrt(DistanceCarre(o));
    }
    
    public double DistanceCarre(CObject o) {
        return (o.posX - posX) * (o.posX - posX)
        		+ (o.posY - posY) * (o.posY - posY);
    }

    public double DistanceCarre(int x, int y) {
        return (x - posX) * (x - posX)
        		+ (y - posY) * (y - posY);
    }

    protected double getPosX() { return posX; }
    protected double getPosY() { return posY; }
}
