extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const Speed = 20

var dead
# Called when the node enters the scene tree for the first time.
func _ready():
	dead = false
	$AnimationPlayer.play("Spawn")


func _process(delta):
	if dead:
		return;
	position.y += Speed * delta

func die():
	dead = true
	$AnimationPlayer.play("Die")
	$AudioStreamPlayer2D.play()

func destroy():
	queue_free()

func _on_Bloop_body_entered(body):
	if dead:
		return;
	if body.is_in_group("player"):
		body.take_damage();
	die()
