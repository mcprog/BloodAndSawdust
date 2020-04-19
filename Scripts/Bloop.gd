extends Area2D


# bloop.gd

const Speed = 95


var direction = Vector2(1, 0)

var dead
var target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	dead = false
	$AnimationPlayer.play("Spawn")
	look_at(target.position)
	direction = direction.rotated(rotation)

func set_up(player):
	target = player

func look_at_object(obj):
	look_at(obj.position)

func _process(delta):
	if dead:
		return;
	position += direction * Speed * delta

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
