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

## Linéarité de la transformée de Fourier
### a. Créer deux images sinusoïdales I1 et I2 avec des valeurs différentes de A et B comme précédemment. Créer ensuite l'image somme I = I1 + I2 ; (normalisée entre 0 et 255) de ces deux images.
### b. Calculer le module de la transformée de Fourier de I en appliquant les différentes étapes précédentes. Afficher l'image résultat. Conclusion.
![](https://i.imgur.com/NalRKxE.png)
- On peut voir distinctement les points de l'image 1 et de l'image 2
### c. Réaliser la même opération en effectuant la somme de plus de 2 images constituées de différentes composantes fréquentielles (différentes valeurs de A et B). Observer le résultat sur le module de la transformée de Fourier. Conclusion.
![](https://i.imgur.com/1c29OBL.png)
- Chaque composantes fréquentielles rajoute deux points sur le module de la transformée de Fourier

## Filtrage dans l'espace des fréquences
### a. Réaliser l'image perturbée en ajoutant à l'image im l'image I de la sinusoïde (sans oublier de convertir im en double). Afficher l'image résultat. Conclusion.
![](https://i.imgur.com/nfGPquk.png)
- On observe notre image perturbée par notre sinusoïde

### b. Afficher l'image du module et localiser les coordonnées des pics.
![](https://i.imgur.com/LLkFXSB.png)

### c. Calculer l'image de la transformée de Fourier de im + I. Afin de pouvoir calculer la transformation inverse, il est nécessaire de conserver les composantes complexes de la transformée de Fourier.
![](https://i.imgur.com/BF0uJji.png)

### d. Réaliser le filtrage dans l'espace des fréquences.
![](https://i.imgur.com/0U7uR0M.png)
- on a retiré de notre image la sinusoïde

# TP N° 3 : Détection de contour

```matlab
et = 5;
imgd2 = imgd + et*randn(size(imgd));
```
## ContourLaPlacien
![](https://i.imgur.com/Ywy99pL.png)

## Canny
![](https://i.imgur.com/2Tf2btm.png)

# TP N° 4 : Segmentation d’image

## Le résultat est l'image imb ne contenant que des « 1 » et des « 2 » correspondant aux deux classes détectées. Afficher l'image segmentée obtenue en la normalisant entre 0 et 64. Conclusion.
![](https://i.imgur.com/yFqFm6f.png)
- On peut voir apercevoir notre nuage en blanc et le ciel en noir
## Extraire deux sous images correspondant respectivement au « nuage » et au « ciel ». Calculer les valeurs moyennes de ces deux sous images. Afficher les histogrammes des deux sous images. Calculer les écarts types des deux sous images.
![](https://i.imgur.com/TbNqTqF.png)

## Calculer analytiquement le seuil de la figure 2. Appliquer ce seuillage sur l'image nuageNDG.bmp Comparer les résultats obtenus avec les deux méthodes (otsu et supervisée). Conclusion.
![](https://i.imgur.com/TIXNCNN.png)
- On voit que avec la méthode supervisée on est plus proche du nuage de départ, on arrive à garder la forme de départ

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
# TP N° 6 : Filtrage de la médiane
## Comparer visuellement les résultats obtenus avec les images filtrées par la méthode de la médiane. Conclusions.
- filtre médiane
![](https://i.imgur.com/KttL0ep.png)
- filtre linéaire
![](https://i.imgur.com/wvhf0df.png)
- On peut voir que le filtre par la méthode de la médiane est plus performant que par la méthode linéaire.

