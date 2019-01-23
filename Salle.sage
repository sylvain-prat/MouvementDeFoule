class Salle:
    def __init__(self,longeur,largeur):
        self.largeur = largeur
        self.longeur = longeur
        self.tabObs = []
        self.tabPt = []
    
    def get(self):
        return line([(0,(self.largeur/2)-2,),(0,0),(self.longeur,0),(self.longeur,self.largeur),(0,self.largeur),(0,(self.largeur/2)+2)])
    
    def addObs(self,obstacle):
        self.tabObs.append(obstacle)
        
    def addPoint(self,point):
        self.tabPt.append(point)
        
    def draw(self):
        goal = point((0,self.largeur/2),rgbcolor='red',size=50)
        room = self.get() + goal
        for i in range (len(self.tabObs)):
            room += self.tabObs[i].get()
        for i in range(len(self.tabPt)):
            room += self.tabPt[i]
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
        
def isIn(point,obstacle):
    return obstacle.pos[0] <= point[0] and point[0] <= obstacle.pos[0] + obstacle.longeur and obstacle.pos[1] <= point[1] and point[1] <= obstacle.pos[1] + obstacle.largeur

    

salle = Salle(50,50)
obs1 = Obstacle((10,10),5,8,salle)
obs2 = Obstacle((20,25),2,12,salle)
obs3 = Obstacle((2,28),10,5,salle)

test = true
for i in range (2,salle.longeur,2):
    for j in range (2,salle.largeur,2):
        for obs in salle.tabObs:
            if(isIn((i,j),obs)):
                test = false
        if test : 
            p = point((i,j),size='2')
            salle.addPoint(p)
            

salle.draw()
