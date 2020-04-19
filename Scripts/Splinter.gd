extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Speed = 425

var direction = Vector2(1, 0)

var target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	look_at(target.position)
	direction = direction.rotated(rotation)

func set_up(player):
	target = player;

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
	pass
