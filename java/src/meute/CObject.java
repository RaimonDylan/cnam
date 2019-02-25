package meute;

// Objet dans le monde (obstacle ou poisson)
public class CObject {
	// Position et longueur
	public double posX;
	public double posY;
	public double longueur;
    
    
    public CObject() {}
    
    public CObject(double posX, double posY, double longueur) {
    	this.posX = posX;
    	this.posY = posY;
    	this.longueur = longueur;
    }
    
    public double Distance(CObject o) {
    	return Math.sqrt((o.posX - posX) * (o.posX - posX) + (o.posY - posY) * (o.posY - posY));
    }
    
    public double DistanceCarre(CObject o) {
    	return (o.posX - posX) * (o.posX - posX) + (o.posY - posY) * (o.posY - posY);
    }
    
    // Getters
    protected double getPosX() { return posX; }
    protected double getPosY() { return posX; }
    protected double getLongueur() { return longueur; }
}
