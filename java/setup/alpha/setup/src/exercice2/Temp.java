package exercice2;

import java.awt.image.BufferedImage;

import javax.swing.JFrame;

public class Temp {

	public static void main(String[] args) throws Exception {
		int matrice[][] = Util.getLennaRedBuffer();
		IImageBuffer img = new ImageBuffer(matrice);
		BufferedImage bImg = ImageFactory.getImage(img);
		JFrame f = new ImageViewer(bImg);
		f.setVisible(true);

	}

}
