extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MinX = -100

const Speed = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	position.x -= Speed * delta;
	if position.x < MinX:
		queue_free()
		print("queing free")
