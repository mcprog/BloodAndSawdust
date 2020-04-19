extends Area2D




var player = null

const Bloop = preload("res://Scenes/Bloop.tscn")

const Offset = 10
const Speed = 30
const MinHeight = 60
const MaxHeight = 200
const ShootCooldown = .9

var patrol_down = true
var shoot_timer
# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_timer = ShootCooldown

func charge_up():
	pass

func shoot():
	var instance = Bloop.instance()
	instance.position = position
	instance.look_at(player.position)
	owner.add_child(instance)
	

func _process(delta):
	var desired_y = position.y
	if player:
		shoot_timer -= delta
		if shoot_timer < 0:
			shoot_timer = ShootCooldown
			shoot()
		desired_y = player.position.y - Offset
		look_at(player.position)
	else:
		if patrol_down:
			if position.y <= MinHeight:
				patrol_down = false
			else:
				desired_y = MinHeight
		else:
			if position.y >= MaxHeight:
				patrol_down = true
			else:
				desired_y = MaxHeight
	position.y = move_toward(position.y, desired_y, Speed * delta)

func die():
	print("alien dieing")
	queue_free()

func _on_Scanner_body_entered(body):
	if not body.is_in_group("player"):
		return;
	player = body



func _on_Scanner_body_exited(body):
	if not body.is_in_group("player"):
		return;
	player = null




