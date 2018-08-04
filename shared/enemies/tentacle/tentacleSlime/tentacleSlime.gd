extends "res://scripts/projectile.gd"

var damageDealt = 10;

func _ready():
	add_to_group('enemy-projectile');
	pass
	
func _physics_process(delta):
	var collisionBody = move_and_collide(Vector2(-2, 0));
	if (collisionBody): handleProjectileCollision();
	
func handleProjectileCollision():
	$CollisionShape2D.disabled = true;
	$TentacleSlime.visible = false;
	$TailParticles.emitting = false;
	$CollisionParticles.emitting = true;
	
func getDamageDealt():
	print('getting damage dealt');
	return 10;