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
		float organicNoise = map(noise(millis()), 0, 1, 0.85, 1.35); 
		//Calculate dir.x based on theta
		//sin(theta) = opp(Y) / h(radius)
		dir.y = sin(p.angle); 
		//cos(theta) = adj(X) / h(radius)
		dir.x = cos(p.angle);

		PVector locationDiff = PVector.sub(location, p.location);
		float distance = locationDiff.mag(); //get distance

		dir.normalize(); //Normalize direction 

		//CONTROL MAGNITUDE OF REPULSION
		//If less that 200px away from epicenter, repel
		if (distance < 80){ 
			float force = map(distance, 0, 80, 1, 0.5) ; //The closer the particle is, the stronger the repulsion. 
			dir.mult(force*organicNoise);
		}
		else if (distance >= 80 && distance < 180){ 
			float force = map(distance, 80, 180, 0.3, 0.01) ; //The closer the particle is, the stronger the repulsion. 
			dir.mult(force*organicNoise);
		}
		//If more than 200px away from epicenter, attract
		//Do NOT repel if more than 80px away
		else if (distance > 220){
			PVector pSpeed = p.velocity.get();
			pSpeed.mult(-0.4); //Opposite direction
			dir = pSpeed; 
		}
/* */
		return dir; 
	}
}


