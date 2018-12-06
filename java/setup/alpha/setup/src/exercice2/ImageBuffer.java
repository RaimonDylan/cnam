package exercice2;
public class ImageBuffer implements IImageBuffer{
	int matrice[][];
	public ImageBuffer(int matrice[][]) {
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
