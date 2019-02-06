from math import *

class Salle:
    def __init__(self,longeur,largeur):
        self.largeur = largeur
        self.longeur = longeur
        self.tabObs = []
        self.tabPt = []
        self.tabLine = []
    
    def get(self):
        return line([(0,(self.largeur/2)-2,),(0,0),(self.longeur,0),(self.longeur,self.largeur),(0,self.largeur),(0,(self.largeur/2)+2)])
    
    def addObs(self,obstacle):
        self.tabObs.append(obstacle)
        
    def addPoint(self,point):
        self.tabPt.append(point)
        
    def addLine(self,line):
        self.tabLine.append(line)
        
    def isIn(self,point,obstacle):
        return obstacle.pos[0] <= point[0] and point[0] <= obstacle.pos[0] + obstacle.longeur and obstacle.pos[1] <= point[1] and point[1] <= obstacle.pos[1] + obstacle.largeur
    
    def drawPt(self):
        for i in range (1,self.longeur,1):
            for j in range (1,self.largeur,1):
                test = true
                for obs in self.tabObs:
                    if(self.isIn((i,j),obs)):
                        test = false
                if test : 
                    p = point((i,j),size='2')
                    self.addPoint(p)
    
    def drawLine(self,point):
        l = line([(0,self.largeur/2),(point[0],point[1])])
        self.addLine(l)
          
    def draw(self):
        goal = point((0,self.largeur/2),rgbcolor='red',size=50)
        room = self.get() + goal
        for i in range (len(self.tabObs)):
            room += self.tabObs[i].get()
        for i in range(len(self.tabPt)):
            room += self.tabPt[i]
        for i in range(len(self.tabLine)):
            room += self.tabLine[i]
        room.show()
        
    def image(self):
        goal = point((0,self.largeur/2),rgbcolor='red',size=50)
        room = self.get() + goal
        for i in range (len(self.tabObs)):
            room += self.tabObs[i].get()
        for i in range(len(self.tabPt)):
            room += self.tabPt[i]
        for i in range(len(self.tabLine)):
            room += self.tabLine[i]
        return room

    def PointIntersectObs(self,point):
        equationPt = equationD((point[0],point[1]),(0, (self.largeur)/2))
        tabIntersect = []
        for obs in self.tabObs :
            for droite in obs.tabEquaD :
                tmp = trouvePtInter(equationPt,droite[1])
                if( tmp != None and VerifIntersection(tmp,droite[0][0],droite[0][1])):
                    tabIntersect.append((tmp,(droite[0][0],droite[0][1]),obs))
        finalPt = ((0,0),((0,0),(0,0)))
        for pt in tabIntersect :
            ptProchePoint = PointLePlusProche(point,pt[0],finalPt[0])
            ptProcheSortie = PointLePlusProche((0,self.largeur/2),pt[0],point)
            if(ptProchePoint == 0 and ptProcheSortie == 0  and ( not pt[2].isCorner(pt[0]))):                
                finalPt = pt
            if(ptProchePoint == 0 and ptProcheSortie == 0  and (pt[2].isCorner(pt[0]))):
                if(pt[0] == pt[2].pos or pt[0] == pt[2].pos2):
                    finalPt = (pt,(pt[2].pos1,pt[2].pos3))
                    #resultat = PointLePlusProche((0,self.largeur/2),pt[2].pos1,pt[2].pos3)
                    #if(resultat == 0):
                    #    finalPt = pt[2].pos1
                    #else :
                    #    finalPt = pt[2].pos3
                if(pt[0] == pt[2].pos1 or pt[0] == pt[2].pos3):
                    finalPt = (pt,(pt[2].pos,pt[2].pos2))                    
                    #resultat = PointLePlusProche((0,self.largeur/2),pt[2].pos,pt[2].pos2)
                    #if(resultat == 0):
                    #    finalPt = pt[2].pos
                    #else :
                    #    finalPt = pt[2].pos2                               
        return finalPt
        
class Obstacle:
    def __init__(self,pos,longeur,largeur,salle):
        self.largeur = largeur
        self.longeur = longeur
        self.pos = pos
        self.pos1 = (self.pos[0]+self.longeur,self.pos[1])
        self.pos2 = (self.pos[0]+self.longeur,self.pos[1]+self.largeur)
        self.pos3 = (self.pos[0],self.pos[1]+self.largeur)
        self.tabEquaD = []
        self.equa1 = equationD(((self.pos[0],self.pos[1])),((self.pos[0]+self.longeur,self.pos[1])))
        self.equa2 = equationD(((self.pos[0]+self.longeur,self.pos[1])),((self.pos[0]+self.longeur,self.pos[1]+self.largeur)))
        self.equa3 = equationD(((self.pos[0]+self.longeur,self.pos[1]+self.largeur)),((self.pos[0],self.pos[1]+self.largeur)))
        self.equa4 = equationD(((self.pos[0],self.pos[1]+self.largeur)),((self.pos[0],self.pos[1])))
        self.addEquaD()
        salle.addObs(self)
        
    def get(self):
        return line([(self.pos[0],self.pos[1]),
                     (self.pos[0]+self.longeur,self.pos[1]),
                     (self.pos[0]+self.longeur,self.pos[1]+self.largeur),
                     (self.pos[0],self.pos[1]+self.largeur),
                     (self.pos[0],self.pos[1])])
    
    def isCorner(self,point):
        return (point == self.pos) or (point[0] == self.pos[0]+self.longeur and point[1] == self.pos[1]) or (point[0] == self.pos[0]+self.longeur and point[1] == self.pos[1]+self.largeur) or (point[0] == self.pos[0] and point[1] == self.pos[1]+self.largeur)
    
    
    def addEquaD(self):
        self.tabEquaD.append(((((self.pos[0],self.pos[1])),((self.pos[0]+self.longeur,self.pos[1]))),self.equa1))
        self.tabEquaD.append(((((self.pos[0]+self.longeur,self.pos[1])),((self.pos[0]+self.longeur,self.pos[1]+self.largeur))),self.equa2))
        self.tabEquaD.append(((((self.pos[0]+self.longeur,self.pos[1]+self.largeur)),((self.pos[0],self.pos[1]+self.largeur))),self.equa3))
        self.tabEquaD.append(((((self.pos[0],self.pos[1]+self.largeur)),((self.pos[0],self.pos[1]))),self.equa4))


def equationD(point1,point2):
    Ya = point1[1]
    Yb = point2[1]
    Xa = point1[0]
    Xb = point2[0]
    if(Xb-Xa == 0):
        return(Xb,None)
    A = (Yb - Ya)/(Xb - Xa)
    B = Ya - A*Xa
    return (A,B)

def trouvePtInter(EquaDroite,EquaObs):
    if(EquaObs[1] != None):
        a = EquaDroite[0]
        b = EquaDroite[1]
        c = EquaObs[0]
        d = EquaObs[1]
        if((c-a) == 0):
            return None
        x = (b-d)/(c-a)
        y = c * x + d
        CoordIntersec = (x,y)
    else:
        a = EquaDroite[0]
        b = EquaDroite[1]
        c = EquaObs[0]
        if(a==0):
            return None
        CoordIntersec = (c,(a*c)+b)
    return CoordIntersec

def VerifIntersection(Coord,CoordObs1, CoordObs2):
    if(Coord[0] >= min(CoordObs1[0],CoordObs2[0]) and Coord[0] <= max(CoordObs2[0],CoordObs1[0])):
        if(Coord[1] >= min(CoordObs1[1],CoordObs2[1]) and Coord[1] <= max(CoordObs1[1],CoordObs2[1])):
            return true
        else:
            return false
    else:
        return false
    
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
    if(Ay == By):
        AB = sqrt( ((Bx - Ax)**2) + ((By - Ay)**2) )
        if(AB < k):
            Dx = AB
            Dy = 0
        else:
            Dx = k
            Dy = 0
    else:
        Cx = Ax
        Cy = By
    
        AC = sqrt( ((Cx - Ax)**2) + ((Cy - Ay)**2) ) 
        AB = sqrt( ((Bx - Ax)**2) + ((By - Ay)**2) )
        BC = sqrt( ((Cx - Bx)**2) + ((Cy - By)**2) )

        #teta = cos(AC/AB)
        

        if(AB < k):
            Dx = abs(Bx-Ax)
            Dy = abs(By-Ay) 
        else:
            Dx = (k*BC)/AB 
            Dy = (k*AC)/AB
            #Dx = acos(teta) * k
            #Dy = asin(teta) * k 
        

    if(Bx < Ax):
        Dx *= -1
    if(By < Ay):
        Dy *= -1
    VSpontanee = (Dx,Dy)
    return VSpontanee


def DeplacementPoint(pointSortie,pt,Salle):
    TabImage = []
    cpt = 0
    while( pointSortie[0] != pt[0] and pointSortie[1] != pt[1]): #Tant que le point ne superpose pas la sortie
        
       
        res = Salle.PointIntersectObs(pt) #Fonction pour verifier si il y a des obstacles
        
        if(res[0] == (0,0)): #Si il ny a aucun obstacle vers la sortie
            print "ici"
            VecSpont = CalculVecteurSpontane(pt,pointSortie) #Calcul du vecteur spontanee du point vers la sortie
        
        else:#il a des obstacles entre la sortie et le point
            
            res2 = PointLePlusProche(pointSortie,res[1][0],res[1][1])
            
            print res[1][0],res[1][1]
            
            if(res2 == 0):
                VecSpont = CalculVecteurSpontane(pt,res[1][0]) #Calcul du vecteur spontanee du point vers le point 0 de l'obstacle
            else:
                VecSpont = CalculVecteurSpontane(pt,res[1][1]) #Calcul du vecteur spontanee du point vers le point 1 de l'obstacle

        pt = (pt[0]+VecSpont[0],pt[1]+VecSpont[1])
        image = Salle.image()
        image += point(pt)
        TabImage.append(image)
        cpt += 1
        if(cpt == 50):
            break
    return TabImage

def DeplacementMultiPoint(pointSortie,pts,Salle):
    TabImage = []
    cpt = 0
    while(allPointSortie(pointSortie,pts)): #Tant que le point ne superpose pas la sortie
        image = Salle.image()
        for i in range (len(pts)):
            res = Salle.PointIntersectObs(pts[i]) #Fonction pour verifier si il y a des obstacles

            if(res[0] == (0,0)): #Si il ny a aucun obstacle vers la sortie
                print "Pts ", i,pointSortie
                VecSpont = CalculVecteurSpontane(pts[i],pointSortie) #Calcul du vecteur spontanee du point vers la sortie

            else:#il a des obstacles entre la sortie et le point

                res2 = PointLePlusProche(pointSortie,res[1][0],res[1][1])

                

                if(res2 == 0):
                    print "Pts ", i, res[1][0]
                    VecSpont = CalculVecteurSpontane(pts[i],res[1][0]) #Calcul du vecteur spontanee du point vers le point 0 de l'obstacle
                else:
                    print "Pts ",i,res[1][1]
                    VecSpont = CalculVecteurSpontane(pts[i],res[1][1]) #Calcul du vecteur spontanee du point vers le point 1 de l'obstacle

            pts[i] = (pts[i][0]+VecSpont[0],pts[i][1]+VecSpont[1])
            image += point(pts[i])
        TabImage.append(image)
        cpt += 1
        if(cpt == 50):
            break
    return TabImage


def allPointSortie(pointSortie,pts):
    for i in range (len(pts)):
        if(pointSortie[0] != pts[i][0] and pointSortie[1] != pts[i][1]):
            return true
    return false

#Permet de créer une animation à partir d'un tableau d'image
def AnimateTab(TabDImage):
    #Regarder la doc de animate http://doc.sagemath.org/html/en/reference/plotting/sage/plot/animate.html
    Animation = animate(TabDImage)
    return Animation

#Permet de créer et d'afficher une animation à partir d'un tableau d'image
def ShowAnimation(TabDImage):
    Animation = AnimateTab(TabDImage)
    Animation.show()
        
salle = Salle(50,50)
obs1 = Obstacle((10,10),5,8,salle)
obs2 = Obstacle((20,25),2,12,salle)
obs3 = Obstacle((2,28),10,5,salle)
obs4 = Obstacle((32,8),6,13,salle)
obs5 = Obstacle((41,30),4,9,salle)
point1 = point((42,12))
point2 = point((8,2))

pt = (42,12)
pt2 = (30,30)
pt3 = (10,40)
pt4 = (15,5)
sortie = (0,25)

tab = DeplacementMultiPoint(sortie,[pt,pt2,pt3,pt4],salle)

ShowAnimation(tab)
