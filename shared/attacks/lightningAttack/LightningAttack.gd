extends Area2D

var PLAYER;
var timeoutCounter = 0;

func _ready():
	pass
	
func emit():
	position = PLAYER.position;
	
	$Lightning1.visible = true;
	$LightningStrikeTimer.start();
	pass
	
func getStartPosition():
	pass

func _on_Timer_timeout():
	if ($Lightning1.visible):
		$Lightning1.visible = false;
		$LightningStrikeTimer.start();
	elif(!$Lightning1.visible && !$Lightning2.visible):
		$Lightning2.visible = true;
		$LightningStrikeTimer.start();
	else:
		$Lightning2.visible = false;
		var bodies = get_overlapping_bodies();
		for i in range(bodies.size()):
			if (bodies[i].is_in_group('enemy')):
				bodies[i].takeLightingDamage();
	pass # replace with function body

