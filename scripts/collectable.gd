extends Area2D

var isCollected = false;
var movementTween;

var LEVEL_MANAGER;

func _ready():
	LEVEL_MANAGER = get_parent().get_node('LevelManager');
	add_to_group('collectable');
	pass
