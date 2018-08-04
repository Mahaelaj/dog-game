extends Area2D

var PLAYER;
var activeMineCount = 0;
func _ready():
	$FireBall1.speed = 20;
	$FireBall2.speed = 25;
	$FireBall3.speed = 30;
	$FireBall4.speed = -40;
	
	$FireBall1.size = 1;
	$FireBall2.size = .4;
	$FireBall3.size = .66;
	$FireBall4.size = .5;
	pass
	
func emit():
	position = PLAYER.position;
	$FireBall1.emit();
	activeMineCount = 1;
	
	$SetMineTimer.start();
	$Timer.start();
	pass
	
func _on_SetMineTimer_timeout():
	if (activeMineCount == 1): 
		$FireBall2.emit();
	elif (activeMineCount == 2): 
		$FireBall3.emit();
	elif (activeMineCount == 3):
		$FireBall4.emit();
		return;
	
	activeMineCount += 1;
	$SetMineTimer.start();
	pass # replace with function body

func _on_Timer_timeout():
	$FireBall1.stop();
	$FireBall2.stop();
	$FireBall3.stop();
	$FireBall4.stop();
	pass # replace with function body
