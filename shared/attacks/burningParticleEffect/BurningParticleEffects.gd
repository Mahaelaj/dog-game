extends Node2D

func _ready():
	pass

func emit():
	$Particles2D.emitting = true;
	
func stopEmitting():
	$Particles2D.emitting = false;