import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
  PImage Quetz,tlaloc,tezca;

ArrayList<Face> faceList;

Rectangle[] faces;

int faceCount = 0;

int scl = 2;

void setup() {
  size(1280, 960);
  video = new Capture(this, width/scl, height/scl);
  opencv = new OpenCV(this, width/scl, height/scl);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  
  faceList = new ArrayList<Face>();
    Quetz = loadImage("quetz.png");
    tlaloc = loadImage("tlaloc.png");
    tezca = loadImage("tezca.png");
  
  video.start();
}

void draw() {
  scale(scl);
  opencv.loadImage(video);
  imageMode(CORNER);
  image(video, 0, 0 );
  
  detectFaces();

  for (int i = 0; i < faces.length; i++) {
   
  }
  
  for (Face f : faceList) {
    f.display();
  }
}

void detectFaces() {

  faces = opencv.detect();

  if (faceList.isEmpty()) {
    for (int i = 0; i < faces.length; i++) {
      println("+++ New face detected with ID: " + faceCount);
      faceList.add(new Face(faceCount, faces[i].x,faces[i].y,faces[i].width,faces[i].height));
      faceCount++;
    }
 
  } else if (faceList.size() <= faces.length) {
    boolean[] used = new boolean[faces.length];
    // Match existing Face objects with a Rectangle
    for (Face f : faceList) {
       // Find faces[index] that is closest to face f
       // set used[index] to true so that it can't be used twice
       float record = 50000;
       int index = -1;
       for (int i = 0; i < faces.length; i++) {
         float d = dist(faces[i].x,faces[i].y,f.r.x,f.r.y);
         if (d < record && !used[i]) {
           record = d;
           index = i;
         } 
       }
       used[index] = true;
       f.update(faces[index]);
    }
    
    for (int i = 0; i < faces.length; i++) {
      if (!used[i]) {
        println("+++ New face detected with ID: " + faceCount);
        faceList.add(new Face(faceCount, faces[i].x,faces[i].y,faces[i].width,faces[i].height));
        faceCount++;
      }
    }
  
  } else {
    for (Face f : faceList) {
      f.available = true;
    } 

    for (int i = 0; i < faces.length; i++) {
       float record = 50000;
       int index = -1;
       for (int j = 0; j < faceList.size(); j++) {
         Face f = faceList.get(j);
         float d = dist(faces[i].x,faces[i].y,f.r.x,f.r.y);
         if (d < record && f.available) {
           record = d;
           index = j;
         } 
       }
       Face f = faceList.get(index);
       f.available = false;
       f.update(faces[i]);
    } 
    for (Face f : faceList) {
      if (f.available) {
        f.countDown();
        if (f.dead()) {
          f.delete = true;
        } 
      }
    } 
  }
  
  for (int i = faceList.size()-1; i >= 0; i--) {
    Face f = faceList.get(i);
    if (f.delete) {
      faceList.remove(i);
    } 
  }
}

void captureEvent(Capture c) {
  c.read();
}
