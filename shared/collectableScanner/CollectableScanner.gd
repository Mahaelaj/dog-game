extends Area2D

func _on_CollectableScanner_area_entered(area):
	if (area.is_in_group('collectable')):
		area.enterPlayerArea();
	pass # replace with function body


func _on_CollectableScanner_area_exited(area):
	if (area.is_in_group('collectable')):
		area.exitPlayerArea();
	pass # replace with function body
