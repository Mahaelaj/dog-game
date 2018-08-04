extends Area2D

var PLAYER = null;

func _ready():
	pass
	
func _physics_process(delta):
	if ($ColdTimer.is_stopped()): return;
	var cameraPosition = PLAYER.position;
	cameraPosition.y += 50;
	position = cameraPosition;
	
	if ($ColdTimer.wait_time - $ColdTimer.time_left < 1):
		$Frost.modulate = Color(1, 1, 1, 0).linear_interpolate(Color(1, 1, 1, 1), $ColdTimer.wait_time - $ColdTimer.time_left);
	
	if ($ColdTimer.time_left < 1):
		$Frost.modulate = Color(1, 1, 1, 0).linear_interpolate(Color(1, 1, 1, 1), $ColdTimer.time_left);
		

func emit():
	$ColdTimer.start();
	$Particles2D.emitting = true;
	var bodies = get_overlapping_bodies();
	for i in range(bodies.size()):
		if (bodies[i].is_in_group('enemy')):
			bodies[i].takeIceDamage();
	pass