extends Node2D
const UP = Vector2(0, -1);
const LIGHTMISSLEREF = null;
const PLAYER = null;
var lightMissles = [];
const Ball1 = null;
const Ball2 = null;
const SPECIAL_ATTACK_BUTTON = null;
var collectedBalls = [];
var soulsCollected = 0;

func _ready():
	LIGHTMISSLEREF = preload("res://shared/attacks/lightAttack/LightMissle.tscn");
	PLAYER = get_parent().get_node('Player');
	Ball1 = get_node("HUD/Ball1");
	Ball2 = get_node("HUD/Ball2");
	SPECIAL_ATTACK_BUTTON = get_node("HUD/SpecialAttack");
	$FireAttack.PLAYER = PLAYER;
	$IceAttack.PLAYER = PLAYER;
	$LightningAttack.PLAYER = PLAYER;
	$IceFireAttack.PLAYER = PLAYER;
	$FireLightningAttack.PLAYER = PLAYER;
	$IceLightningAttack.PLAYER = PLAYER;

func _on_NormalAttack_pressed():
	if (!$LightAttackTimer.is_stopped()): return;
	var playerRobe = PLAYER.get_node('PlayerSprite/Robe');
	var lightMissle = LIGHTMISSLEREF.instance();
	lightMissle.setRightDirection(!playerRobe.flip_h);
	if (!playerRobe.flip_h):
		lightMissle.position = PLAYER.position + Vector2(30, 0);
	else:
		lightMissle.position = PLAYER.position + Vector2(-30, 0);
	add_child(lightMissle);
	
	PLAYER.shoot();

	$LightAttackTimer.start();
	
func addBall(type):
	if (collectedBalls.size() == 2): return false;
	var ball = null;
	if (collectedBalls.size() == 0): ball = Ball1;
	else:
		ball = Ball2;
		SPECIAL_ATTACK_BUTTON.disabled = false;
	if (type == 'ice'): ball.texture = load("res://shared/attacks/balls/iceBall/ice_ball.png");
	elif (type == 'fire'): ball.texture = load("res://shared/attacks/balls/fireBall/fire_ball.png");
	elif (type == 'lightning'): ball.texture = load("res://shared/attacks/balls/lightningBall/lightning_ball.png");
	collectedBalls.append(type);
	return true;
	pass;

func _on_SpecialAttack_pressed():
	SPECIAL_ATTACK_BUTTON.disabled = true;
	if (collectedBalls[0] == 'fire' && collectedBalls[1] == 'fire'): $FireAttack.emit();
	if (collectedBalls[0] == 'ice' && collectedBalls[1] == 'ice'): $IceAttack.emit();
	if (collectedBalls[0] == 'lightning' && collectedBalls[1] == 'lightning'): $LightningAttack.emit();
	if (collectedBalls.has('fire') && collectedBalls.has('ice')): $IceFireAttack.emit();
	if (collectedBalls.has('fire') && collectedBalls.has('lightning')): $FireLightningAttack.emit();
	if (collectedBalls.has('ice') && collectedBalls.has('lightning')): $IceLightningAttack.emit();
	
	pass # replace with function body

func _on_IceAttack_endColdAttack():
	var enemies = get_tree().get_nodes_in_group("enemy");
	for i in enemies.size():
        enemies[i].setCold(false);
	pass # replace with function body

func collectSoul():
	soulsCollected += 1;
	get_node('HUD/SoulsLabel').text = 'X ' + str(soulsCollected);
