extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angular_velocity = 0

func die():
	queue_free()

func _on_Blood_body_entered(body):
	if body.is_in_group("player"):
		body.add_blood()
		body.add_blood()
		die()


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.add_blood()
		body.add_blood()
		die()
