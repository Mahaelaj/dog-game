extends Area2D

var speed = 0;
var size = 0;
var rotating = false;

func _ready():
	pass
	
func _process(delta):
	if (rotating): rotation_degrees += delta * speed;

func emit():
	visible = true;
	$Tween1.interpolate_property(self, "scale", Vector2(0, 0), Vector2(size, size), .75, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween1.start();
	$Tween2.interpolate_callback(self, .75, "growLasers");
	$Tween2.start();
	
func growLasers():
	$Tween1.interpolate_property($Laser1, "scale", $Laser1.scale, Vector2($Laser1.scale.x, 2.3), .75, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween1.start();
	
	$Tween1.interpolate_property($Laser2, "scale", $Laser1.scale, Vector2($Laser1.scale.x, 2.3), .75, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween1.start();
	rotating = true;
	
func stop():
	$Tween1.interpolate_property(self, "scale", Vector2(size, size), Vector2(0, 0), .75, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween1.start();
	
	$Tween2.interpolate_callback(self, .75, "hide");
	$Tween2.start();
	
func hide():
	visible = false;
	$Laser1.scale = Vector2(0.5, 0.5);
	$Laser2.scale = Vector2(0.5, 0.5);
	
func _on_FireBall_body_entered(body):
	if (!visible): return;
	if (body.is_in_group('enemy')): 
		body.takeFireLightningDamage();
	pass # replace with function body
