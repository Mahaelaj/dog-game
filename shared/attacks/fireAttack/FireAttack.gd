extends Area2D

var PLAYER;

func _ready():
	$Timer.wait_time = $Particles2D.lifetime - 4;
	pass
	
func emit():
	$Timer.start();
	$Particles2D.emitting = true;

func _physics_process(delta):
	if ($Timer.is_stopped()): return;
	
	var playerRobe = PLAYER.get_node('PlayerSprite/Robe');
	if (playerRobe.flip_h):
		position = PLAYER.position + Vector2(-30, 0);
		rotation_degrees = 180;
	else:
		position = PLAYER.position + Vector2(30, 0);
		rotation_degrees = 0;

func _on_FireAttack_body_entered(body):
	if ($Timer.is_stopped() || !body.is_in_group('enemy')): return;
	body.takeFireDamage();
	pass # replace with function body


func _on_Timer_timeout():
	var bodies = get_overlapping_bodies();
	for i in range(bodies.size()):
		if (bodies[i].is_in_group('enemy')):
			bodies[i].setBurning();
	pass # replace with function body
