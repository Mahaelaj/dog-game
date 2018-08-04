extends "res://scripts/enemy.gd"
var SLIMEREF;

func _ready():
	initEnemy(20, 25, 25);
	SLIMEREF = preload("res://shared/enemies/tentacle/tentacleSlime/tentacleSlime.tscn");
	pass

func _physics_process(delta):
	if ($RayCastFront.is_colliding() && $ShootTimer.time_left == 0):
		var slime = SLIMEREF.instance();
		add_child(slime);
		$ShootTimer.start();
	pass;
		
func takeFireDamage():
	setBurning();
	pass;
	
func takeIceDamage():
	takeDamage(iceDamageTaken);
	setCold(true);
	$ColdTimer.wait_time = coldTimerWaitTime;
	$ColdTimer.start();
	pass;
	
func takeIceFireDamage():
	if ($ColdTimer.time_left < coldFireTimerWaitTime):
		$ColdTimer.wait_time = coldFireTimerWaitTime;
		$ColdTimer.start();
		setCold(true);
	takeDamage(iceFireDamageTaken);
	pass;
	
func takeIceLightningDamage():
	takeDamage(iceLightningDamageTaken);
	setCold(true);
	isLightningIced = true;
	$IceLightningTimer.start();
	pass;

func stopIceLightningDamage():
	setCold(false);
	isLightningIced = false;
	pass;
	
func setCold(val):
	isCold = val;
	spriteHueCounter = 0;
	if (val): $AnimatedSprite.get_sprite_frames().set_animation_speed("default", 2.0);
	else: $AnimatedSprite.get_sprite_frames().set_animation_speed("default", 5.0);
	pass;

func takeLightingDamage():
	takeDamage(lightningDamageTaken);
	$LightningAnimatedSprite.visible = true;
	isShocked = true;
	$LightningAnimatedSprite.play('default');
	$AnimatedSprite.stop();
	$ShockedTimer.start();
	pass;

func _on_ColdTimer_timeout():
	setCold(false);
	pass # replace with function body

func _on_ShockedTimer_timeout():
	isShocked = false;
	$LightningAnimatedSprite.visible = false;
	$LightningAnimatedSprite.stop();
	$AnimatedSprite.play('default');
	pass # replace with function body

func _on_IceLightningTimer_timeout():
	if (!isLightningIced): return;
	takeDamage(iceLightningDamageTaken);
	$IceLightningTimer.start();
	pass # replace with function body

func takeFireLightningDamage():
	takeDamage(fireLightningDamageTaken);
	setBurning();
	pass;
	
func setBurning():
	$BurningParticleEffects1.emit();
	$BurningParticleEffects2.emit();
	$BurningParticleEffects3.emit();
	$BurningTimer.start();
	isBurning = true;
	pass;
	
func _on_BurningTimer_timeout():
	$BurningParticleEffects1.stopEmitting();
	$BurningParticleEffects2.stopEmitting();
	$BurningParticleEffects3.stopEmitting();
	isBurning = false;
	timeTillNextBurn = 1;
	pass;
	
func die():
	var deathParticlesRef = preload("res://shared/enemies/tentacle/DeathParticles.tscn");
	var deathParticles = deathParticlesRef.instance();
	var tentacleWindow = get_node('TentacleWindow');
	remove_child(tentacleWindow);
	get_parent().add_child(deathParticles);
	get_parent().add_child(tentacleWindow);
	deathParticles.position = position;
	tentacleWindow.position = position + tentacleWindow.position;
	queue_free();
	pass 