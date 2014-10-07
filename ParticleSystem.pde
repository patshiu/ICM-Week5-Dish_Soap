class ParticleSystem {
	//Each particle system contains
	//Location 
	//Repeller is at the center
	//Particles get created on click
	//Custom size for falloff radius possible. 
	PVector origin;
	ArrayList<InkParticle> particles;
	InkRepeller epicenter; 

	//ParticleSystem Constructor 
	//Create new array list, populate with particles
	//Create new repeller
	ParticleSystem(PVector location) {
		origin = location.get();
		particles = new ArrayList<InkParticle>();
		epicenter = new InkRepeller(origin); 
	}

  void addParticle() {
  	//Instead of adding one new particle, add 360 degrees of new particles?
  	for (float i = 0; i <= 360; i += 0.5){
  		particles.add(new InkParticle(origin, i));
  	}
  }

  void applyForce(PVector f) {
	//Using an enhanced loop to apply the force to all particles
    for (InkParticle p: particles) {
      p.applyForce(f);
    }
  }

  void run(){
	//Apply force to all particles
	Iterator<InkParticle> it = particles.iterator();
	while (it.hasNext()) {
	  InkParticle p = (InkParticle) it.next();
	  p.applyForce(epicenter.repel(p));
	  p.run();
	  if (p.alive() == false) {
	    it.remove();
	  }
	}
  }
}


