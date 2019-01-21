#Prend en entrée une matrice ou chaque ligne correspond à un point avec ses coordonnées et sa vitesse
def CuckerSmale(TabPosition):
    #Constante à choisir
    h = 0.033
    newTabPosition = []
    for i in range (len(TabPosition)):
        newLigneTabPosition = []
        newLigneTabPosition.append(X(TabPosition,i,h))
        newLigneTabPosition.append(V(TabPosition,i,h))
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
def X(Tab,i,h):
    XiX = Tab[i][0][0]
    XiY = Tab[i][0][1]
    ViX = Tab[i][1][0]
    ViY = Tab[i][1][1]
    
    
    newCoord = (( XiX + (h*ViX) ), ( XiY + (h*ViY) ))
    return newCoord

#Fonction permettant de calculer la nouvelle vitesse d'un point
def V(TabPosition,i,h):
    #Vitesse du point I
    ViX = TabPosition[i][1][0]
    ViY = TabPosition[i][1][1]
    #Coordonnées du point I
    XiX=TabPosition[i][0][0]
    XiY=TabPosition[i][0][1]

    
    #Constante lambda à choisir
    lmd = 1
    
    #Constante beta pour phi à choisir
    beta = 1
    
    #Nombre d'individu
    N = len(TabPosition)
    
    #Calcul de la somme
    SommeX = 0
    SommeY = 0
    for j in range (N):
        #Coordonnées du point J
        XjX=TabPosition[j][0][0]
        XjY=TabPosition[j][0][1]
        #Vitesse du point J
        VjX=TabPosition[j][1][0]
        VjY=TabPosition[j][1][1]
        SommeX += phi(abs(XiX-XjX),beta) * (VjX - ViX)
        SommeY += phi(abs(XiY-XjY),beta) * (VjY - ViY)   
    
    newViX = ViX + h * (lmd / N) * SommeX
    newViY = ViY + h * (lmd / N) * SommeY
    
    newVi = (newViX,newViY)
    return newVi

#Fonction phi, force d'interaction entre l'individu i et l'individu j
def phi(x,b):
    return 1/((1+(x^2))^b)


def ModelisationCuckerSmale(TabPosition,Salle):
    MatriceCoord = []
    convertTab(TabPosition,MatriceCoord)
    for i in range (80):
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
       
TabPosition = [[(1,1),(2,3.2)],
               [(1,2),(3,4.2)],
               [(1,3),(2,2.5)],
               [(2,1),(2.6,2.3)],
               [(2,2),(2.6,1.3)],
               [(2,3),(1,3.4)],
               [(3,1),(1.3,4.2)],
               [(1.5,2.5),(3,4.2)],
               [(1.5,3.5),(2,2.5)],
               [(2.5,1.5),(2.6,2.3)],
               [(2.5,2.5),(2.6,1.3)],
               [(2.5,3.5),(1,3.4)],
               [(3.5,1.5),(1.3,4.2)],
               [(2.5,0.5),(0,1.3)]]


Salle = line([(0,0),(0,20),(20,20),(20,0),(0,0)])
ModelisationCuckerSmale(TabPosition,Salle)


