extends "res://scripts/character.gd"

var damageDealt = 0;
var iceDamageTaken = 20;
var iceFireDamageTaken = 40;
var iceLightningDamageTaken = 15;
var lightningDamageTaken = 20;
var fireLightningDamageTaken = 5;
var fireDamage = 75;
var burnDamage = 3;
var timeTillNextBurn = 1;

var speed = 0;
var spriteHueCounter = 1;
var isCold = false;
var isShocked = false;
var isLightningIced = false;
var isBurning = false;

var coldTimerWaitTime = 8;
var coldFireTimerWaitTime = 4;

func _ready():
	add_to_group('enemy');
	pass
	
func _process(delta):
	spriteHueCounter += delta/2
	if (spriteHueCounter > 1): spriteHueCounter = 1;
	if (isCold): $AnimatedSprite.modulate = Color(1, 1, 1, 1).linear_interpolate(Color(.5, .8, 1, 1), spriteHueCounter);
	else: $AnimatedSprite.modulate = Color(.5, .8, 1, 1).linear_interpolate(Color(1, 1, 1, 1), spriteHueCounter);

func checkForPlayerCollision(collision):
	if (collision != null && collision.collider.is_in_group('player')):
		collision.collider.takeDamage(damageDealt);

func initEnemy(initHealth, initDamageDealt, initSpeed):
	health = initHealth;
	damageDealt = initDamageDealt;
	speed = initSpeed;
	pass
	
func getDamageDealt():
	return damageDealt;
	
