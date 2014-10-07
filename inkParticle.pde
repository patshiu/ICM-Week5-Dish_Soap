class InkParticle {
	//Variables containing info about an InkParticle

	//- color (HSBA) 
	//- location
	//- velocity
	//- acceleration
	//- mass
	//- live or dead (how long before the particle fades)
	//- epicenter / origin (point that it is repelling from)
	PVector location; 
	PVector velocity;
	PVector acceleration; 
	PVector friction;
	color inkColor; 

	float angle;
	float lifespan; //controls alpha
	float mass = 1; 
	boolean alive;
	
	//InkParticle constructor
	InkParticle(PVector l, float theta) {
		location = l.get();
		acceleration = new PVector(0,0);
		angle = radians(theta + map(noise(millis()), 0, 1, -6, 6));
		inkColor = color(theta, 50, 80, 100);
		velocity = new PVector(0, 0);
		//sin(theta) = opp(Y) / h(radius)
		velocity.y = sin(theta) * 0.05; 
		//cos(theta) = adj(X) / h(radius)
		velocity.x = cos(theta) * 0.05;

		alive = true;  
		lifespan = 200.0;
	}

	//InkParticle location updater
	void update() {
		applyFriction();
		velocity.add(acceleration); //Update velocity according to acceleration
		velocity.limit(35);
		location.add(velocity); //Update location according to velocity
		acceleration.mult(0); //set acceleration back to zero
		lifespan -= 3.0;
	}
	//Physics calculator	
	void applyForce(PVector force){
		PVector f = force.get();
		f.div(mass);
		acceleration.add(f);
	}

	void applyFriction(){
		friction = velocity.get();
		friction.normalize();
		friction.mult(-0.5);
		applyForce(friction);
	}

	//InkParticle displayer
	void display() {
		colorMode(HSB, 360, 100, 100, 100);
		float velocityMag = velocity.mag();
		//Tool to find a nice color
/*		float startingHue = map(mouseY, 0, height, 0, 360);
		println(startingHue);*/
		float startingHue = 200.0;
		float hue = map( velocityMag, 0, 5, startingHue, startingHue + 40);

		//Draw big transparent circle
		noStroke();
		inkColor = color(hue-20, 60, 80, lifespan-100);
		fill(inkColor);
		ellipse(location.x,location.y, 20, 20);

		//Then draw little circle
		inkColor = color(hue, 60, 99, lifespan);
		stroke(inkColor);
		fill(inkColor);
		ellipse(location.x,location.y,1,1);

	}

	//Run the particles 
	void run(){
		update();
		display();
	}

	//InkParticle lifespan manager
	boolean alive() {
		if (lifespan < 0.0 ) {
			return false;
		} 
		else if (location.x < 0 || location.x > width || location.y < 0 || location.y > height) {
			return false;
		}
		else {
			return true;
		}
	}
}