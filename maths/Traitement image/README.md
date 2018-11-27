# RAPPORT DES TP - Traitement image
# TP N° 1 : Filtrage linéaire

```matlab
perf = sqrt(sum(sum((imf-imf1).^2))/(n*m))
```
Calcul de la performance du filtre où imf est l'image non bruitée et imf1 l'image bruitée puis filtrée.
## 1 - Visualiser les deux images et constater les effets du bruit pour différentes valeurs de et.
![](https://i.imgur.com/xooJY4O.png)
## 2 - Visualiser les différentes images filtrées. Que constate-t-on ?
![](https://i.imgur.com/dS0KoyL.png)
![](https://i.imgur.com/jS7d914.png)


# TP N° 2 : Transformée de Fourier
## Transformée de Fourier d'une image sinusoïdale
### a. Afficher l'image I à l’aide de la fonction imshow() pour différentes valeurs de A et B. Conclusion.
![](https://i.imgur.com/Wu7pnbd.png)
- Varier A modifie la fréquence et varier B modifie la direction
### b. Déterminer la transformée de Fourier de l'image I. Pour cela nous allons utiliser la fonction matlab fft2 
![](https://i.imgur.com/bJxuUP9.png)
### c. Réaliser la manipulation pour différentes valeurs de A et B. Observer l'évolution des composantes fréquentielles.
- Plus A est élevé plus le point est loin. Varier B reviens à varier la direction


# TP N° 5 : Segmentation par attributs de texture


## 1 - Afficher l'image normalisée entre 0 et 64. Qu'observe-t-on ? Conclusion.
![](https://i.imgur.com/yLLlFsL.png)
niveaux de gris homogènes
## 2 - 
  * 2 - a. Calculer les valeurs moyennes des deux images attributs. Conclusion.
  * 2 - b. Afficher les histogrammes des deux images attributs. On utilise pour cela la fonction hist(). Conclusion ?
  ![](https://i.imgur.com/462Mn84.png)
## 3 -
  * 3 - a. En utilisant la fonction otsu() fournie calculer l'image segmentée de texture3.tif
  * 3 - b. Segmentation supervisée. 
  * Calculer la valeur moyenne et l'écart type de l'attribut
  * Calculer l'image binaire par seuillage
  ![](https://i.imgur.com/XgfHAwy.png)
  ![](https://i.imgur.com/UyDaSSw.png)

