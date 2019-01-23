#Créer une image à partir d'une coordonnées (pour un seul point)
def CreateImage(TabDImage,Coord):
    c = line([(0,0),(0,10),(10,10),(10,0),(0,0)]) + point([Coord[0],Coord[1]])
    TabDImage.append(c)
    return TabDImage

#Créer une image à partir d'un tableau de coordonnées
def CreateMultiplePoint(TabDImage,TabCoord):
    Image = line([(0,0),(0,10),(10,10),(10,0),(0,0)])
    for i in range(len(TabCoord)):
        Image += point([TabCoord[i][0],TabCoord[i][1]])
    TabDImage.append(Image)
    return TabDImage

#Fonction permetant de générer plusieurs images à partir d'une matrice ou chaque ligne correspond à un tableau de coordonnées 
def CreateMultipleImage(TabDImage,MatriceCoord,Salle):
    for i in range(len(MatriceCoord)):
        Image = Salle
        for j in range(len(MatriceCoord[i])):
            Image += point([MatriceCoord[i][j][0],MatriceCoord[i][j][1]])
        TabDImage.append(Image) 
    return TabDImage
#Permet d'afficher toutes les images d'un tableau
def AfficheTab(TabDImage):
    for i in range (6):
        TabDImage[i].show()
    return 0

#Permet de créer une animation à partir d'un tableau d'image
def AnimateTab(TabDImage):
    #Regarder la doc de animate http://doc.sagemath.org/html/en/reference/plotting/sage/plot/animate.html
    Animation = animate(TabDImage)
    return Animation

#Permet de créer et d'afficher une animation à partir d'un tableau d'image
def ShowAnimation(TabDImage):
    Animation = AnimateTab(TabDImage)
    Animation.show()

#Test
TabDImage =[]
TabCoord = [[(1,1),(9,9)],[(2,2),(8,8)],[(3,3),(7,7)]]
Salle = line([(0,0),(0,10),(10,10),(10,0),(0,0)])
TabDImage = CreateMultipleImage(TabDImage,TabCoord,Salle)
ShowAnimation(TabDImage)
