extends "res://scripts/collectable.gd"

func enterPlayerArea():
	var startPos = position;
	$SoulParticles.emitting = true;
	$SoulParticles2.emitting = true;
	$SoulParticles3.emitting = true;
	$SoulParticles4.emitting = true;
	$Tween.interpolate_property(self, "position", startPos, Vector2(startPos.x, startPos.y - 20), 4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "position", Vector2(startPos.x, startPos.y - 20), startPos, 4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 4)
	$Tween.start();
	
func exitPlayerArea():
	$SoulParticles.emitting = false;
	$SoulParticles2.emitting = false;
	$SoulParticles3.emitting = false;
	$SoulParticles4.emitting = false;
	$Tween.stop(self, "position");

func _on_Timer_timeout():
	queue_free();
	pass # replace with function body

func _on_Soul_body_entered(body):
	if (!body.is_in_group('player') || isCollected): return;
	
	isCollected = true;
	$Sprite.modulate.a = 0;
	$SoulParticles.emitting = false;
	$SoulParticles2.emitting = false;
	$SoulParticles3.emitting = false;
	$SoulParticles4.emitting = false;
	$Timer.start();
	LEVEL_MANAGER.collectSoul();
	
	pass # replace with function body
