import peasy.*;
import java.util.*;
import java.lang.Math;

PeasyCam cam;

float size = 5;
int wSize = 600;
int scl = 100;

void setup() {
  size(600, 600, P3D);
  //translate(width/2, height/2);
  //rotateeZ(PI/3, points, pointsW);
  frameRate(100);
  cam = new PeasyCam(this, 300, 300, 0, 500);
  ////cam.setMinimumDistance(50);
  ////cam.setMaximumDistance(500);
}

int[][] faces = {
  {0, 1, 2, 3},
  {4, 5, 6, 7},
  {4, 5, 1, 0},
  {6, 7, 3, 2},
  {4, 7, 3, 0},
  {5, 6, 2, 1},
  {8, 9, 10, 11},
  {12, 13, 14, 15},
  {12, 13, 9, 8},
  {14, 15, 11, 10},
  {12, 15, 11, 8},
  {13, 14, 10, 9},
  
  {0, 1, 9, 8},
  {4, 5, 13, 12},
  {3, 2, 10, 11},
  {7, 6, 14, 15},
  {0, 3, 11, 8},
  {4, 7, 15, 12},
  {1, 2, 10, 9},
  {5, 6, 14, 13},
  
  {4, 0, 8, 12},
  {5, 1, 9, 13},
  {7, 3, 11, 15},
  {6, 2, 10, 14}
};

int pn = 16;

PVector[] points = {new PVector(-1, -1, -1),
                    new PVector(1, -1, -1),
                    new PVector(1, 1, -1),
                    new PVector(-1, 1, -1),
                    new PVector(-1, -1, 1),
                    new PVector(1, -1, 1),
                    new PVector(1, 1, 1),
                    new PVector(-1, 1, 1),
                    new PVector(-1, -1, -1),
                    new PVector(1, -1, -1),
                    new PVector(1, 1, -1),
                    new PVector(-1, 1, -1),
                    new PVector(-1, -1, 1),
                    new PVector(1, -1, 1),
                    new PVector(1, 1, 1),
                    new PVector(-1, 1, 1)
                    };
                    
float[] pointsW = {1, 1, 1, 1, 1, 1, 1, 1, -1, -1, -1, -1, -1, -1, -1 , -1};
                    
int cn = 32;

int[][] conections = {{0, 1},
                        {1, 2},
                        {2, 3},
                        {3, 0},
                        {4, 5},
                        {5, 6},
                        {6, 7},
                        {7, 4},
                        {0, 4},
                        {1, 5},
                        {2, 6},
                        {3, 7},
                        {8, 9},
                        {9, 10},
                        {10, 11},
                        {11, 8},
                        {12, 13},
                        {13, 14},
                        {14, 15},
                        {15, 12},
                        {8, 12},
                        {9, 13},
                        {10, 14},
                        {11, 15},
                        {0, 8},
                        {1, 9},
                        {2, 10},
                        {3, 11},
                        {4, 12},
                        {5, 13},
                        {6, 14},
                        {7, 15}
                        };


void rotateeX(float angle, PVector[] points, float[] pointsW) {
  for (int i = 0; i < pn; i++) {
    float oldPoint = points[i].y;
     points[i].y = points[i].y * cos(angle) - points[i].z * sin(angle);
     points[i].z = oldPoint * sin(angle) + points[i].z * cos(angle);
  }
}

void rotateeY(float angle, PVector[] points, float[] pointsW) {
  for (int i = 0; i < pn; i++) {
    float oldPoint = points[i].x;
     points[i].x = points[i].x * cos(angle) + points[i].z * sin(angle);
     points[i].z = -oldPoint * sin(angle) + points[i].z * cos(angle);
  }
}

void rotateeZ(float angle, PVector[] points, float[] pointsW) {
  for (int i = 0; i < pn; i++) {
    float oldPoint = points[i].x;
     points[i].x = points[i].x * cos(angle) - points[i].y * sin(angle);
     points[i].y = oldPoint * sin(angle) + points[i].y * cos(angle);
  }
}

void rotateeXW(float angle, PVector[] points, float[] pointsW) {
  for (int i = 0; i < pn; i++) {
    float oldPoint = points[i].x;
    points[i].x = points[i].x * cos(angle) - pointsW[i] * sin(angle);
    pointsW[i] = oldPoint * sin(angle) + pointsW[i] * cos(angle);
  }
}

void rotateeYW(float angle, PVector[] points, float[] pointsW) {
  for (int i = 0; i < pn; i++) {
    float oldPoint = points[i].y;
    points[i].y = points[i].y * cos(angle) - pointsW[i] * sin(angle);
    pointsW[i] = oldPoint * sin(angle) + pointsW[i] * cos(angle);
  }
}
void rotateeZW(float angle, PVector[] points, float[] pointsW) {
  for (int i = 0; i < pn; i++) {
    float oldPoint = points[i].z;
    points[i].z = points[i].z * cos(angle) - pointsW[i] * sin(angle);
    pointsW[i] = oldPoint * sin(angle) + pointsW[i] * cos(angle);
  }
}

PVector project(PVector point, float pointW) {
  float w = 1 / (2 - pointW);
  w = 1;
  
  PVector newPoint = new PVector(point.x * w, point.y * w, point.z * w);
  
  return newPoint;
}

void sizeUp(float[] pointsW) {
  for (int i = 0; i < 16; i++) {
    pointsW[i] += 0.1;
  }
}

float angle = 0;
void draw() {
  //sizeUp(pointsW);
  //rotateeX(PI/180, points, pointsW);
  //rotateeY(PI/180, points, pointsW);
  //rotateeZ(PI/180, points, pointsW);
  //rotateeW(PI/180, points, pointsW);
  background(0);
  translate(width/2, height/2);
  rotateX(PI/4);
  rotateeX(PI/180, points, pointsW);
  rotateeY(PI/180, points, pointsW);
  rotateeZ(PI/180, points, pointsW);
  rotateeXW(PI/180, points, pointsW);
  rotateeYW(PI/180, points, pointsW);
  rotateeZW(PI/180, points, pointsW);
  angle += 0.01;
  for(int i = 0; i < pn; i++) {
    PVector projected = project(points[i], pointsW[i]);
    stroke(0, 255, 0);
    //strokeWeight(16);
    //point(projected.x * scl, projected.y * scl, projected.z * scl);
  }
  
  lights();
  fill(100);
  noStroke();
  for(int i = 0; i < 24; i++) {
    fill(255 - i*0);
    //noFill();
    beginShape();
    for(int j = 0; j < 4; j++) {
      PVector pro = project(points[faces[i][j]], pointsW[faces[i][j]]);
      //vertex(points[faces[i][j]].x * scl, points[faces[i][j]].y * scl, points[faces[i][j]].z * scl);
      vertex(pro.x * scl, pro.y * scl, pro.z * scl);
    }
    endShape();
   }
   //for(int i = 0; i < cn; i++) {
   //   PVector projected0 = project(points[conections[i][0]], pointsW[conections[i][0]]);
   //   PVector projected1 = project(points[conections[i][1]], pointsW[conections[i][1]]);
   //   stroke(0, 255, 0);
   //   strokeWeight(1);
   //   line(projected0.x * scl, projected0.y * scl, projected0.z * scl, projected1.x * scl, projected1.y * scl, projected1.z * scl);
   //   line(projected0.x * scl, projected0.y * scl, projected0.z * scl, projected1.x * scl, projected1.y * scl, projected1.z * scl);  
   //}
  //noLoop();
}

void mousePressed() {
}
