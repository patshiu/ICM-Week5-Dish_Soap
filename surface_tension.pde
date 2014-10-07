import java.util.Iterator;

ParticleSystem ps; 


void setup() {
	size(500, 500);
  colorMode(HSB, 360, 100, 100, 100);
	PVector l = new PVector(width/2, height/2);
	ps = new ParticleSystem(l);
	background(0, 0, 100, 100);
  //frameRate(10);
}

void draw() {
  fill(0, 0, 100, 5);
  noStroke();
  rect(0, 0, width, height);
  ps.run();
}

void mousePressed(){
  ps.addParticle();
}
