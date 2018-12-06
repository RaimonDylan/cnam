package exercice2;

import java.awt.image.BufferedImage;

import javax.swing.JFrame;

public class Temp {

	public static void main(String[] args) throws Exception {
		int matrice[][] = Util.getLennaRedBuffer();
		IRasterBuffer img = new RasterBuffer(matrice);
		BufferedImage bImg = RasterFactory.getImage(img);
		JFrame f = new RasterViewer(bImg);
		f.setVisible(true);

	}

}
