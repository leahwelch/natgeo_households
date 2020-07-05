//Toxic Libs
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

Attractor a;
int i;

color[] cols;
color col;

// Reference to physics "world" (2D)
VerletPhysics2D physics;
float tx, ty;
Jelly jelly;

//float amplitude = 5;
float angle = 0.0;

PImage[] softs = new PImage[22];
PImage soft;


void setup() {
  size(600,600, P2D);
  
  physics=new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.01)));
  
  for (int i = 0; i < softs.length; i ++ ) {
    softs[i] = loadImage( "soft_" + (i+1) + ".png" );
  }
  cols = new color[22];
    
  cols[0] = color(249,238,183);
  cols[1] = color(229,216,149);
  cols[2] = color(204,189,125);
  cols[3] = color(180,168,113);
  cols[4] = color(163,145,100);
  cols[5] = color(117,101,82);
  cols[6] = color(116,90,70);
  cols[7] = color(105,72,59);
  cols[8] = color(95,55,45);
  cols[9] = color(80,38,35);
  cols[10] = color(71,23,25);
  cols[11] = color(91,18,24);
  cols[12] = color(109,12,23);
  cols[13] = color(125,27,45);
  cols[14] = color(140,43,54);
  cols[15] = color(162,67,64);
  cols[16] = color(175,82,59);
  cols[17] = color(191,104,55);
  cols[18] = color(202,122,62);
  cols[19] = color(214,143,71);
  cols[20] = color(214,158,83);
  cols[21] = color(214,171,95);
  
  col = cols[0];
  soft = softs[0];
  
  jelly = new Jelly(40,60,col, soft);
  
  a = new Attractor();
}

void draw() {
  background(2,1,32);
  smooth();
  
  col = cols[i+8];
  soft = softs[i+8];
  i = int(8*sin(angle));
  //println(i);
  
  // Update physics
  physics.update();
  PVector force = a.attract(jelly);
  jelly.applyForce(force);
  jelly.update();
  //jelly.checkEdges();
  //b.borders();
  jelly.run();
  
  tx += 0.01;
  ty += 0.01;
  angle += 0.02;
}
