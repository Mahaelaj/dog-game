extends KinematicBody2D

var health = 0;
const UP = Vector2(0, -1);
const GRAVITY = 10;
const MAX_SPEED = 200;
const JUMP_HEIGHT = -500;
const ACCELERATION = 50;

func initCharacter(init_health):
	health = init_health;
	pass;

func takeDamage(damage):
	print(damage);
	health -= damage;
	if (health <= 0): die();
	pass
	



