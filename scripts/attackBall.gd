extends "res://scripts/collectable.gd"
	
func collectBall(body, ball_type):
	if (body.is_in_group('player')): 
		var ballAdded = LEVEL_MANAGER.addBall(ball_type);
		if (ballAdded): queue_free();
	pass;

