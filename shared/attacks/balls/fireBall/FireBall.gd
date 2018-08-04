extends "res://scripts/attackBall.gd"

const PLAYER = null;

func _ready():
	pass

func _on_FireBall_body_entered(body):
	collectBall(body, 'fire');
	pass # replace with function body
