import java.util.Iterator;

ParticleSystem ps; 


void setup() {
	size(500, 500);
  colorMode(HSB);
	PVector l = new PVector(width/2, height/2);
	ps = new ParticleSystem(l);
	background(0);
  frameRate(10);
}

void draw() {
  fill(0, 0, 0, 60);
  noStroke();
  rect(0, 0, width, height);
  noFill();
  //stroke(255,0,200, 255);
  //ellipse(width/2, height/2, 200, 200);
  ps.run();
}

void mousePressed(){
  ps.addParticle();
}
