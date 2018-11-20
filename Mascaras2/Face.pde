class Face {
  
  Rectangle r;

  boolean available;

  boolean delete;

  int timer = 2;

  int id;

  Face(int newID, int x, int y, int w, int h) {
    r = new Rectangle(x,y,w,h);
    available = true;
    delete = false;
    id = newID;
  }

  void display() {
    if(id==0){
     tint(255, 235);
    imageMode(CENTER);
    image (tlaloc,r.x+(r.width/1.8),r.y+(r.height/6),r.width*1.7,r.width*1.8);
    }
    if(id==1){
     imageMode(CORNER);
     image (Quetz,r.x - (r.width/3.5),r.y-(r.height/2.9),r.width*1.5, r.width*2);
    }
     if(id==2){
     tint(255, 235);
    imageMode(CENTER);
    image (tezca,r.x+(r.width/2),r.y+(r.height/3),r.width*1.2,r.width*2.2);
    }
    if(id==3){
     tint(255, 235);
    imageMode(CENTER);
    image (tlaloc,r.x+(r.width/1.8),r.y+(r.height/6),r.width*1.7,r.width*1.8);
    }
    if(id==4){
     imageMode(CORNER);
     image (Quetz,r.x - (r.width/3.5),r.y-(r.height/2.9),r.width*1.5, r.width*2);
    }
     if(id==5){
     tint(255, 235);
    imageMode(CENTER);
    image (tezca,r.x+(r.width/2),r.y+(r.height/3),r.width*1.2,r.width*2.2);
    }
    if(id==6){
     tint(255, 235);
    imageMode(CENTER);
    image (tlaloc,r.x+(r.width/1.8),r.y+(r.height/6),r.width*1.7,r.width*1.8);
    }
    if(id==7){
     imageMode(CORNER);
     image (Quetz,r.x - (r.width/3.5),r.y-(r.height/2.9),r.width*1.5, r.width*2);
    }
     if(id==8){
     tint(255, 235);
    imageMode(CENTER);
    image (tezca,r.x+(r.width/2),r.y+(r.height/3),r.width*1.2,r.width*2.2);
    }
    

  }

  void update(Rectangle newR) {
    r = (Rectangle) newR.clone();
  }

  void countDown() {
    timer--;
  }

  boolean dead() {
    if (timer < 0) return true;
    return false;
  }
}
