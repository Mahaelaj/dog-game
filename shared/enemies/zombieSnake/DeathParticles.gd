extends Node2D

func _ready():
	#$Particles2D.one_shot = true;
	$Particles2D.emitting = true;
	$Particles2D2.emitting = true;
	$Particles2D3.emitting = true;
	pass


func _on_LifeTimer_timeout():
	queue_free();
	pass # replace with function body
