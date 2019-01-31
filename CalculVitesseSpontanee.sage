def PointLePlusProche(pointSortie,pointObs0,pointObs1):
    Sx = pointSortie[0]
    Sy = pointSortie[1]
    
    O0x = pointObs0[0]
    O0y = pointObs0[1]
    
    O1x = pointObs0[0]
    O1y = pointObs0[1]
    
    SO0 = sqrt( ((O0x - Sx)**2) + ((O0y - Sy)**2) )
    SO1 = sqrt( ((O1x - Sx)**2) + ((O1y - Sy)**2) )
    
    if(SO0 <= SO1):
        return 0
    else:
        return 1

def CalculVecteurSpontane(pointDepart,pointArrivee):
    k = 1 #Constante à définir, distance parcourue par un point    
    Ax = pointDepart[0]
    Ay = pointDepart[1]
    
    Bx = pointArrivee[0]
    By = pointArrivee[1]
    
    Cx =
    Cy =
    
    AC = sqrt( ((Cx - Ax)**2) + ((Cy - Ay)**2) ) 
    AB = sqrt( ((Bx - Ax)**2) + ((By - Ay)**2) )
    
    teta = cos(AC/AB)
    
    Dx = asin(teta) * k
    Dy = acos(teta) * k
    
    VSpontanee = (Dx,Dy)
    
    return VSpontanee

def DeplacementPoint(pointSortie,point,Salle):
    while(pointSortie[0][0][0] != point[0][0][0] and pointSortie[0][0][1] != point[0][0][1]): #Tant que le point ne superpose pas la sortie
        
        res = TracerLigne() #Fonction pour verifier si il y a des obstacles
        
        if(res == None): #Si il ny a aucun obstacle vers la sortie
            
            VecSpont = CalculVecteurSpontane(point,pointSortie) #Calcul du vecteur spontanee du point vers la sortie
        
        else:#il a des obstacles entre la sortie et le point
            
            TrouverPointObstacleDeIntersection()
            res = PointLePlusProche(pointSortie,pointObs0,pointObs1)
            
            if(res == 0):
                VecSpont = CalculVecteurSpontane(point,pointObs0) #Calcul du vecteur spontanee du point vers le point 0 de l'obstacle
            else:
                VecSpont = CalculVecteurSpontane(point,pointObs1) #Calcul du vecteur spontanee du point vers le point 1 de l'obstacle
            
        Deplacement(point,VecSpont)
        
