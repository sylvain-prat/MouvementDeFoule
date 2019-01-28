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
        
    def equationD(self,point1,point2):
        Ya = point1[0][0][1]
        Yb = point2[0][0][1]
        Xa = point1[0][0][0]
        Xb = point2[0][0][0]
        A = (Yb - Ya)/(Xb - Xa)
        B = Ya - A*Xa
        return (A,B)
  
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
        
class Obstacle:
    def __init__(self,pos,longeur,largeur,salle):
        self.largeur = largeur
        self.longeur = longeur
        self.pos = pos
        salle.addObs(self)
        
    def get(self):
        return line([(self.pos[0],self.pos[1]),
                     (self.pos[0]+self.longeur,self.pos[1]),
                     (self.pos[0]+self.longeur,self.pos[1]+self.largeur),
                     (self.pos[0],self.pos[1]+self.largeur),
                     (self.pos[0],self.pos[1])])
        

salle = Salle(50,50)
obs1 = Obstacle((10,10),5,8,salle)
obs2 = Obstacle((20,25),2,12,salle)
obs3 = Obstacle((2,28),10,5,salle)
obs4 = Obstacle((32,8),6,13,salle)
obs5 = Obstacle((41,30),4,9,salle)
point1 = point((7,-3))
point2 = point((8,2))
 
print salle.equationD(point1,point2)
