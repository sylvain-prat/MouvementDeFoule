def PointLePlusProche(pointSortie,pointObs0,pointObs1):
    Sx = pointSortie[0][0][0]
    Sy = pointSortie[0][0][1]
    
    O0x = pointObs0[0][0][0]
    O0y = pointObs0[0][0][1]
    
    O1x = pointObs0[0][0][0]
    O1y = pointObs0[0][0][1]
    
    SO0 = sqrt( ((O0x - Sx)**2) + ((O0y - Sy)**2) )
    SO1 = sqrt( ((O1x - Sx)**2) + ((O1y - Sy)**2) )
    
    if(SO0 <= SO1):
        return 0
    else:
        return 1

def CalculVecteurSpontane(pointDepart,pointArrivee):
    k = 1 #Constante à définir, distance parcourue par un point    
    Ax = pointDepart[0][0][0]
    Ay = pointDepart[0][0][1]
    
    Bx = pointArrivee[0][0][0]
    By = pointArrivee[0][0][1]
    
    Cx =
    Cy =
    
    AC = sqrt( ((Cx - Ax)**2) + ((Cy - Ay)**2) ) 
    AB = sqrt( ((Bx - Ax)**2) + ((By - Ay)**2) )
    
    teta = cos(AC/AB)
    
    Dx = asin(teta) * k
    Dy = acos(teta) * k
    
    VSpontanee = (Dx,Dy)
    
    return VSpontanee
