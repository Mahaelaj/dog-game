extends Area2D
var PLAYER = null;

var IceLightningEnemies = [];

func _ready():
	pass
	
func emit():
	position = PLAYER.position;
	$BallParticles2D.visible = true;
	$BallParticles2D.emitting = true;
	$Tween.interpolate_property(get_node("BallParticles2D"), "scale", Vector2(0.1, 0.1), Vector2(1, 1), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start();
	$Timer.start();
	
	var bodies = get_overlapping_bodies();
	for i in range(bodies.size()):
		if (bodies[i].is_in_group('enemy')):
			bodies[i].takeIceLightningDamage();
			IceLightningEnemies.append(bodies[i]);
	pass;

func _on_Timer_timeout():
	$Tween.interpolate_property(get_node("BallParticles2D"), "scale", Vector2(1, 1), Vector2(0, 0), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start();
	$Tween.interpolate_callback(self, 2, "stopAttack");
	for i in range(IceLightningEnemies.size()):
		if (IceLightningEnemies[i].is_in_group('enemy')):
			IceLightningEnemies[i].stopIceLightningDamage();
	IceLightningEnemies = [];
	pass # replace with function body
	
func stopAttack():
	$BallParticles2D.visible = false;
	$BallParticles2D.emitting = false;
	pass;

func _on_IceLightningAttack_body_entered(body):
	if (body.is_in_group('enemy')):
		body.takeIceLightningDamage();
		IceLightningEnemies.append(body);
	pass # replace with function body

func _on_IceLightningAttack_body_exited(body):
	if (body.is_in_group('enemy')):
		body.stopIceLightningDamage();
	pass # replace with function body
