extends "res://scripts/attackBall.gd"

func _ready():
	pass

func _on_IceBall_body_entered(body):
	collectBall(body, 'ice');
	pass # replace with function body
