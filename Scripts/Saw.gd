extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const RotateSpeed = 14.5

var quadrant
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show():
	if visible:
		return;
	visible = true
	$SawOrigin.rotation = -PI / 2
	$AnimationPlayer.play("Saw")

func hide():
	if not visible:
		return;
	$AnimationPlayer.stop()
	visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("attack"):
		$RayCast2D.look_at(get_global_mouse_position())
		quadrant = cos($RayCast2D.rotation)
		if (quadrant > 0):
			$SawOrigin/Area2D.scale = Vector2(.5, .5)
		else:
			$SawOrigin/Area2D.scale = Vector2(.5, -.5)
	
	$SawOrigin.rotation = lerp_angle($SawOrigin.rotation, $RayCast2D.rotation, delta * RotateSpeed)
	
	
	

func _on_Area2D_body_entered(body):
	if not visible:
		return;
	
	if body.is_in_group("wood"):
		body.start_sawing()
	elif body.is_in_group("enemy"):
		body.die()


func _on_Area2D_body_exited(body):
	if not visible:
		return;
	if body.is_in_group("wood"):
		body.stop_sawing()


func _on_Area2D_area_entered(area):
	if not visible:
		return;
	if area.is_in_group("enemy"):
		area.die()
