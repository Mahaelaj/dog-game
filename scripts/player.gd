extends "res://scripts/character.gd"

var motion = Vector2();
var queuedAnimation = null;

const ROBESPRITE = null;
const FACESPRITE = null;
const SHOOTANIMTIMER = null;
const SHOOTTIMER = null;

func _ready():
	add_to_group('player');
	FACESPRITE = get_node("PlayerSprite/Face");
	ROBESPRITE = get_node("PlayerSprite/Robe");
	SHOOTANIMTIMER = get_node("PlayerSprite/Face/ShootAnimTimer");
	SHOOTTIMER = get_node("PlayerSprite/ShootTimer");
	initCharacter(100);
		
func _physics_process(delta):
	motion.y += GRAVITY;
	var friction = false;
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED);
		ROBESPRITE.play("run");
		if(SHOOTANIMTIMER.is_stopped()): FACESPRITE.play("run");
		
		ROBESPRITE.flip_h = false;
		FACESPRITE.flip_h = false;
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED);
		ROBESPRITE.play("run");
		if(SHOOTANIMTIMER.is_stopped()): FACESPRITE.play("run");
	
		ROBESPRITE.flip_h = true;
		FACESPRITE.flip_h = true;
	else:
		ROBESPRITE.play("idle");
		if(SHOOTANIMTIMER.is_stopped()): FACESPRITE.play("idle");
		friction = true;
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			friction = true;
			motion.y = JUMP_HEIGHT;
		if friction:
			motion.x = lerp(motion.x, 0, 0.2);
	else:
		if motion.y < 0: 
			ROBESPRITE.play("jump");
			if(SHOOTANIMTIMER.is_stopped()): FACESPRITE.play("jump");
		elif motion.y >= 0:
			ROBESPRITE.play("fall");
			if(SHOOTANIMTIMER.is_stopped()): FACESPRITE.play("fall");
		if friction:
			motion.x = lerp(motion.x, 0, 0.05);
		
	motion = move_and_slide(motion, UP);
	
func shoot():
	FACESPRITE.play("shoot");
	SHOOTANIMTIMER.start();
	
func _on_Robe_frame_changed():
	pass

func _on_Area2D_body_entered(body):
	if (!body.is_in_group('enemy') && !body.is_in_group('enemy-projectile')): return;
	takeDamage(body.getDamageDealt());
	$TakeDamageTimer.start();
	if (body.is_in_group('enemy-projectile')): body.handleProjectileCollision();
	
func _on_TakeDamageTimer_timeout():
	var bodies = $Area2D.get_overlapping_bodies()

	for i in range(bodies.size()):
		if (bodies[i].is_in_group('enemy')):
			takeDamage(bodies[i].getDamageDealt());
			$TakeDamageTimer.start();
			return;
	pass # replace with function body

func die():
	var camera = get_node('Camera2D');
	self.remove_child(camera);
	get_parent().add_child(camera);
	camera.set_owner(get_parent());
	camera.position += position;
	
	var deathParticlesRef = preload("res://shared/player/DeathParticles.tscn");
	var deathParticles = deathParticlesRef.instance();
	get_parent().add_child(deathParticles);
	deathParticles.position = position;
	queue_free();
	pass
