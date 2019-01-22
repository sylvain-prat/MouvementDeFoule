class Salle:
    def __init__(self,longeur,largeur):
        self.largeur = largeur
        self.longeur = longeur
        self.tabObs = []
    
    def get(self):
        return line([(0,(self.largeur/2)-2,),(0,0),(self.longeur,0),(self.longeur,self.largeur),(0,self.largeur),(0,(self.largeur/2)+2)])
    
    def addObs(self,obstacle):
        self.tabObs.append(obstacle)
        
    def draw(self):
        goal = point((0,self.largeur/2),rgbcolor='red',size=50)
        room = self.get() + goal
        for i in range (len(self.tabObs)):
            room += self.tabObs[i].get()
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
salle.draw()
