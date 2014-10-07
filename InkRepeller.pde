class InkRepeller {
	//Variables containing info about the repeller
	//-location
	//-magnitude of repulsion 
	//-active? 
	PVector location; 
	float repelStrength; 
	boolean active; 


	InkRepeller(PVector l) {
		location = l.get();
		repelStrength = 1; 
		active = true; 
	}

	PVector repel(InkParticle p) {
		PVector dir = new PVector(); //Direction of repulsion
		float organicNoise = map(noise(millis()), 0, 1, -0.002, 0.002); 
		//Calculate dir.x based on theta
		//sin(theta) = opp(Y) / h(radius)
		dir.y = sin(p.angle + organicNoise); 
		//cos(theta) = adj(X) / h(radius)
		dir.x = cos(p.angle + organicNoise);

		PVector locationDiff = PVector.sub(location, p.location);
		float distance = locationDiff.mag(); //get distance

		dir.normalize(); //Normalize direction 

		//CONTROL MAGNITUDE OF REPULSION
		//If less that 200px away from epicenter, repel
		if (distance < 40){ 
			float force = map(distance, 0, 40, 1, 0.5) ; //The closer the particle is, the stronger the repulsion. 
			dir.mult(force);
		}
		else if (distance >= 40 && distance < 90){ 
			float force = map(distance, 40, 90, 0.2, 0) ; //The closer the particle is, the stronger the repulsion. 
			dir.mult(force);
		}
		//If more than 200px away from epicenter, attract
		//Do NOT repel if more than 80px away
		else if (distance > 100){
			PVector pSpeed = p.velocity.get();
			pSpeed.mult(-0.5); //Opposite direction
			dir = pSpeed; 
		}
/* */
		return dir; 
	}
}


