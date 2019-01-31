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
        l = line([(0,self.largeur/2),(point[0][0][0],point[0][0][1])])
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
        

    def PointIntersectObs(self,point):
        equationPt = equationD((point[0],point[1]),(0, (self.largeur)/2))
        tabIntersect = []
        for obs in self.tabObs :
            for droite in obs.tabEquaD :
                tmp = trouvePtInter(equationPt,droite[1])
                if( tmp != None and VerifIntersection(tmp,droite[0][0],droite[0][1])):
                    tabIntersect.append(tmp)
        finalPt = (0,0)
        for point in tabIntersect :
            if(point[0] > finalPt[0]):
                finalPt = point
        return finalPt
        
class Obstacle:
    def __init__(self,pos,longeur,largeur,salle):
        self.largeur = largeur
        self.longeur = longeur
        self.pos = pos
        self.tabEquaD = []
        self.addEquaD()
        salle.addObs(self)
        
    def get(self):
        return line([(self.pos[0],self.pos[1]),
                     (self.pos[0]+self.longeur,self.pos[1]),
                     (self.pos[0]+self.longeur,self.pos[1]+self.largeur),
                     (self.pos[0],self.pos[1]+self.largeur),
                     (self.pos[0],self.pos[1])])
    
    def addEquaD(self):
        equa1 = equationD(((self.pos[0],self.pos[1])),((self.pos[0]+self.longeur,self.pos[1])))
        equa2 = equationD(((self.pos[0]+self.longeur,self.pos[1])),((self.pos[0]+self.longeur,self.pos[1]+self.largeur)))
        equa3 = equationD(((self.pos[0]+self.longeur,self.pos[1]+self.largeur)),((self.pos[0],self.pos[1]+self.largeur)))
        equa4 = equationD(((self.pos[0],self.pos[1]+self.largeur)),((self.pos[0],self.pos[1])))
        self.tabEquaD.append(((((self.pos[0],self.pos[1])),((self.pos[0]+self.longeur,self.pos[1]))),equa1))
        self.tabEquaD.append(((((self.pos[0]+self.longeur,self.pos[1])),((self.pos[0]+self.longeur,self.pos[1]+self.largeur))),equa2))
        self.tabEquaD.append(((((self.pos[0]+self.longeur,self.pos[1]+self.largeur)),((self.pos[0],self.pos[1]+self.largeur))),equa3))
        self.tabEquaD.append(((((self.pos[0],self.pos[1]+self.largeur)),((self.pos[0],self.pos[1]))),equa4))


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
        
salle = Salle(50,50)
obs1 = Obstacle((10,10),5,8,salle)
obs2 = Obstacle((20,25),2,12,salle)
obs3 = Obstacle((2,28),10,5,salle)
obs4 = Obstacle((32,8),6,13,salle)
obs5 = Obstacle((41,30),4,9,salle)
point1 = point((42,12))
point2 = point((8,2))
 
salle.drawLine(point1)
print salle.PointIntersectObs((42,12))
salle.draw()
                  
