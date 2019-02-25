package meute;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.Observable;
import java.util.Observer;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;

import javax.swing.JPanel;

// L'affichage de notre simulation
public class OceanJPanel extends JPanel implements Observer, MouseListener {
    protected Ocean ocean;
    protected Timer timer;
    protected Random generateur;

    
    public OceanJPanel() {
        generateur = new Random();
        this.setBackground(new Color(255, 255, 255));
        this.addMouseListener(this);
    }
    
    public void Lancer() {
        ocean = new Ocean(Ocean.NB_POISSONS, this.getWidth(), getHeight());
        ocean.addObserver(this);
        
        for(int i = 0; i < Ocean.NB_OBSTACLES; i++) {
        	ocean.AjouterObstacle(
        			generateur.nextDouble()*1680,
        			generateur.nextDouble()*1000,
        			generateur.nextDouble()*20);
        }

        
        TimerTask tache = new TimerTask() {
            @Override
            public void run() {
                ocean.MiseAJourOcean();
            }
        };
        timer = new Timer();
        timer.scheduleAtFixedRate(tache, 0, 1);
    }

    protected void DessinerPoisson(Poisson p, Graphics g) {
    	Color color;
    	switch(p.familles) {
    	case 0:
    		color = new Color(255, 0, 0);
    		break;
    	case 1:
    		color = new Color(0, 255, 0);
    		break;
    	case 2:
    		color = new Color(0, 0, 255);
    		break;
    	default:
    		color = new Color(0);
    	}
    	int taille = 6;
    	if(p.selected) {
    		taille = 15;
    		System.out.println(p);
    		g.drawOval((int)p.posY, (int) p.posX, 30, 30);
    	}
    	
    	g.setColor(color);
    	g.drawLine((int) p.posX, (int) p.posY, (int) (p.posX - p.longueur * p.vitesseX), (int)( p.posY - p.longueur * p.vitesseY));
    	g.fillArc((int) p.posX-3, (int) p.posY-3, taille, taille, 0, 360);
    }
    protected void DessinerObstacle(ZoneAEviter o, Graphics g) {
        g.setColor(Color.decode("#FF6600"));
        g.fillOval((int) (o.posX - o.rayon), (int) (o.posY - o.rayon), (int) o.rayon * 2, (int) o.rayon * 2);
    }
    
    @Override
    public void update(Observable o, Object arg) {
        this.repaint();
    }
    
    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        for(Poisson p : ocean.poissons) {
        	DessinerPoisson(p,g);
        }
        for(ZoneAEviter o : ocean.obstacles) {
        	DessinerObstacle(o,g);
        }
    }

	@Override
	public void mouseClicked(MouseEvent e) {
		if( e.getButton() == MouseEvent.BUTTON1) {
			ocean.AjouterObstacle(e.getX(),  e.getY(), 10);
		}
		else if(e.getButton() == MouseEvent.BUTTON3) {
			Poisson p;
			p = ocean.poissons[0];
			for (Poisson poisson : ocean.poissons) {
				if((p.getPosX() - e.getX() < poisson.getPosX() - e.getX()) && (p.getPosY() - e.getY() < poisson.getPosY() - e.getY())) {
					p = poisson;
				}
			}
			p.isSelected();
		}
	}

	@Override
	public void mouseEntered(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mouseExited(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mousePressed(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mouseReleased(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

    // Gestion du clic souris (ajout d'obstacles).
    // TODO
}
