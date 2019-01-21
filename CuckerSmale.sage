#Prend en entrée une matrice ou chaque ligne correspond à un point avec ses coordonnées et sa vitesse
def CuckerSmale(TabPosition):
    newTabPosition = []
    for i in range (len(TabPosition)):
        newLigneTabPosition = []
        newLigneTabPosition.append(X(TabPosition,i))
        newLigneTabPosition.append(V(TabPosition,i))
        newTabPosition.append(newLigneTabPosition)
    return newTabPosition

#Permet de changer un tableau position en un tableau de coordonnées (pour l'affichage)
def convertTab(TabPosition,TabCoord):
    newLigneTabCoord = []
    for i in range (len(TabPosition)):
        newLigneTabCoord.append(TabPosition[i][0])
    TabCoord.append(newLigneTabCoord)
    return TabCoord
    
#Fonction permettant de calculer la nouvelle position d'un point
def X(Tab,i):
    newCoord = ((Tab[i][0][0]+Tab[i][1][0]),(Tab[i][0][1]+Tab[i][1][1]))
    return newCoord

def V(Tab,i):
    return Tab[i][1]
#Fonction phi, force d'interaction entre l'individu i et l'individu j
def phi(x,b):
    return 1/((1+(x^2))^b)


def ModelisationCuckerSmale(TabPosition,Salle):
    MatriceCoord = []
    convertTab(TabPosition,MatriceCoord)
    for i in range (5):
        TabPosition = CuckerSmale(TabPosition)
        convertTab(TabPosition,MatriceCoord)
    
    TabDImage = []
    TabDImage = CreateMultipleImage(TabDImage,MatriceCoord,Salle)

    ShowAnimation(TabDImage)
    
    
    
    
#TEST
def CreateMultipleImage(TabDImage,MatriceCoord,Salle):
    for i in range(len(MatriceCoord)):
        Image = Salle
        for j in range(len(MatriceCoord[i])):
            Image += point([MatriceCoord[i][j][0],MatriceCoord[i][j][1]])
        TabDImage.append(Image) 
    return TabDImage
def AnimateTab(TabDImage):
    #Regarder la doc de animate http://doc.sagemath.org/html/en/reference/plotting/sage/plot/animate.html
    Animation = animate(TabDImage)
    return Animation
def ShowAnimation(TabDImage):
    Animation = AnimateTab(TabDImage)
    Animation.show()
    
    
TabPosition = [[(1,1),(1,0)],[(1,2),(1,0)],[(1,3),(1,0)]]
Salle = line([(0,0),(0,10),(10,10),(10,0),(0,0)])
ModelisationCuckerSmale(TabPosition,Salle)


