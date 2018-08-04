extends "res://scripts/projectile.gd"

var motion = Vector2();
var speed = 3.5;
var damage = 20;

func setRightDirection(right_direction):
	if ((right_direction && speed < 0) || (!right_direction && speed > 0)): speed *= -1
	if (!right_direction): $TailParticles.rotation_degrees = 0;
	
func _physics_process(delta):
	var collision = move_and_collide(Vector2(speed,0));
	if (!collision): return;
	$CollisionShape2D.disabled = true;
	$Tween.interpolate_property(get_node("Sprite"), "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), .75, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start();
	$TailParticles.emitting = false;
	$CollisionParticles.emitting = true;
	
	if (collision.collider.is_in_group('enemy')):
		collision.collider.takeDamage(damage);
	
	speed = 0;

