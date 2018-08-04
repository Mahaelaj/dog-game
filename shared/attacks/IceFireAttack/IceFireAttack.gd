extends Area2D

var moving = false;
var centerYPos;
var timeMoving = 0;
var PLAYER = null;
var moveLeft = false;

func _ready():
	centerYPos = position.y;

func emit():
	timeMoving = 0;
	if (!PLAYER.get_node('PlayerSprite/Robe').flip_h):
		position = PLAYER.position + Vector2(50, 0);
		moveLeft = false;
		rotation_degrees = 0;
	else:
		position = PLAYER.position + Vector2(-50, 0);
		moveLeft = true;
		rotation_degrees = 180;
		
	centerYPos = PLAYER.position.y;
	visible = true;
	$Tween.interpolate_property($IceFireBall, 'scale', Vector2(0.01, 0.01), Vector2(0.5, 0.5), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT); 
	$Tween.start();

func _process(delta):
	if (!moving): return;
	var speed = 100;
	if (moveLeft): speed *= -1;
	
	position.x += speed * delta;
	timeMoving += delta * 2;
	position.y = centerYPos + 40 * sin(timeMoving);
	if (abs(PLAYER.position.x - position.x) > 650):
		moving = false;
		visible = false;
		$Particles2D.emitting = false;
		position = Vector2(-1000, -1000);
		
func _on_Tween_tween_completed(object, key):
	$Particles2D.emitting = true;
	moving = true;
	pass # replace with function body

func _on_IceFireAttack_body_entered(body):
	print(body);
	if (body.is_in_group('enemy')):
		body.takeIceFireDamage();
	pass # replace with function body
