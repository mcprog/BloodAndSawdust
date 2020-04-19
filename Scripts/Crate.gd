extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SawTime = 2


var saw_timer = -1;

func start_sawing():
	saw_timer = 0
	$AnimationPlayer.play("Breaking")

func stop_sawing():
	saw_timer = -1
	$AnimationPlayer.stop()

func die():
	$AnimationPlayer.play("Break")

func destroy():
	var instance = $Sawdust.duplicate()
	instance.visible = true
	instance.global_position = $Sawdust.global_position
	owner.add_child(instance)
	queue_free()

func _process(delta):
	if saw_timer >= 0:
		saw_timer += delta
	if saw_timer >= SawTime:
		die()
