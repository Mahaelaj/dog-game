extends KinematicBody2D

func _ready():
	add_to_group('projectile');
	
func startDestroyTimer():
	$DestroyTimer.start();

func destroyProjectile():
	queue_free();
	
func _on_DestroyTimer_timeout():
	destroyProjectile();
	pass # replace with function body
