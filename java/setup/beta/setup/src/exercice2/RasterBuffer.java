package exercice2;
public class RasterBuffer implements IRasterBuffer{
	int matrice[][];
	public RasterBuffer(int matrice[][]) {
		this.matrice = matrice;
	}

	@Override
	public int[][] getValues() {
		return this.matrice;
	}

	@Override
	public int getWidth() {
		return this.matrice.length;
	}

	@Override
	public int getHeight() {
		return this.matrice[0].length;
	}
	
}
