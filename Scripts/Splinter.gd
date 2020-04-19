extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Speed = 95

var direction = Vector2(1, 0)
# Called when the node enters the scene tree for the first time.
func _ready():
	direction = direction.rotated(rotation)



func _process(delta):
	
	position += direction * Speed * delta

func die():
	print("splinter died")
	queue_free()

func _on_Splinter_body_exited(body):
	print("body exited (splinter)")
	if body.is_in_group("player"):
		print("splintered player")
		body.take_damage(2)
	die()
		


func _on_Splinter_body_entered(body):
	if body.is_in_group("player"):
		return
	die()
