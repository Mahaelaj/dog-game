extends KinematicBody2D

var defaultYPos;
var movingDown = true;

func _ready():
	defaultYPos = position.y;
	pass
	
func _physics_process(delta):
	move_and_slide(Vector2(0, -20));
	#if (movingDown):
		
		#print(constant_linear_velocity);
		#constant_linear_velocity = Vector2(0, -50);
	pass
	