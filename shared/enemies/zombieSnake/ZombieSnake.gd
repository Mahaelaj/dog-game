extends "res://scripts/enemy.gd"

func _ready():
	initEnemy(20, 25, 25);
	$AnimatedSprite.play('tailUp');
	pass
	
func _process(delta):
	if (!isBurning): return;
	timeTillNextBurn -= delta;
	if (timeTillNextBurn < 0):
		takeDamage(burnDamage);
		timeTillNextBurn = 1;
	
func _physics_process(delta):
	if (isShocked): return;
	if ($RayCastFront.is_colliding()):
		var body = $RayCastFront.get_collider();
		if(body && body.is_in_group('player')):
			if (isCold): speed = 10;
			else: speed = 25;
			if (body.position.x < position.x): speed *= -1;
			if (scale.x != 1): scale.x = 1
			if ($AnimatedSprite.animation == 'idle'): $AnimatedSprite.play('tailDown');
		
	if ($RayCastBack.is_colliding()):
		var body = $RayCastBack.get_collider();
		if(body && body.is_in_group('player')):
			if (scale.x == 1): scale.x = -1;
		pass
	
	if (!isPlayerInRaycast()): speed = 0;
		
	if( $AnimatedSprite.animation == 'tailDown'):
		move_and_slide(Vector2(speed, 0), UP, 0, 1, 0);

func _on_AnimatedSprite_animation_finished():
	if (!isPlayerInRaycast()): $AnimatedSprite.play('idle');
	elif ($AnimatedSprite.animation == 'tailDown'): $AnimatedSprite.play('tailUp');
	else: $AnimatedSprite.play('tailDown');
	pass # replace with function body

func isPlayerInRaycast():
	if ($RayCastFront.is_colliding() && $RayCastFront.get_collider() && $RayCastFront.get_collider().is_in_group('player')): return true;
	if ($RayCastBack.is_colliding() && $RayCastBack.get_collider() && $RayCastBack.get_collider().is_in_group('player')): return true;
	return false;
	pass
	
func takeFireDamage():
	setBurning();
	
func takeIceDamage():
	takeDamage(iceDamageTaken);
	setCold(true);
	$ColdTimer.wait_time = coldTimerWaitTime;
	$ColdTimer.start();
	
func takeIceFireDamage():
	if ($ColdTimer.time_left < coldFireTimerWaitTime):
		$ColdTimer.wait_time = coldFireTimerWaitTime;
		$ColdTimer.start();
		setCold(true);
	takeDamage(iceFireDamageTaken);
	
func takeIceLightningDamage():
	takeDamage(iceLightningDamageTaken);
	spriteHueCounter = 0;
	isCold = true;
	isLightningIced = true;
	$IceLightningTimer.start();

func stopIceLightningDamage():
	spriteHueCounter = 0;
	isCold = false;
	isLightningIced = false;
	
func setCold(val):
	isCold = val;
	spriteHueCounter = 0;
	
func takeLightingDamage():
	takeDamage(lightningDamageTaken);
	$LightningAnimatedSprite.visible = true;
	isShocked = true;
	$LightningAnimatedSprite.play('default');
	$AnimatedSprite.stop();
	$ShockedTimer.start();

func _on_ColdTimer_timeout():
	setCold(false);
	pass # replace with function body

func _on_ShockedTimer_timeout():
	isShocked = false;
	$LightningAnimatedSprite.visible = false;
	$LightningAnimatedSprite.stop();
	$AnimatedSprite.play('idle');
	pass # replace with function body

func _on_IceLightningTimer_timeout():
	if (!isLightningIced): return;
	takeDamage(iceLightningDamageTaken);
	$IceLightningTimer.start();
	pass # replace with function body

func takeFireLightningDamage():
	takeDamage(fireLightningDamageTaken);
	setBurning();
	
func setBurning():
	$BurningParticleEffects1.emit();
	$BurningParticleEffects2.emit();
	$BurningTimer.start();
	isBurning = true;
	
func _on_BurningTimer_timeout():
	$BurningParticleEffects1.stopEmitting();
	$BurningParticleEffects2.stopEmitting();
	isBurning = false;
	timeTillNextBurn = 1;
	
func die():
	var deathParticlesRef = preload("res://shared/enemies/zombieSnake/DeathParticles.tscn");
	var deathParticles = deathParticlesRef.instance();
	get_parent().add_child(deathParticles);
	deathParticles.position = position;
	queue_free();
	pass 
