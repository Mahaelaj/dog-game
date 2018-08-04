extends "res://scripts/attackBall.gd"

func _on_LightningBall_body_entered(body):
	collectBall(body, 'lightning');
	pass # replace with function body
