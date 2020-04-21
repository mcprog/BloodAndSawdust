extends Area2D




var player = null

const Bloop = preload("res://Scenes/Bloop.tscn")
const Blood = preload("res://Scenes/Blood.tscn")

const Offset = 70
const Speed = 30
const MinHeight = -300
const MaxHeight = 50 # technically, the lowest on the screen aline can go
const ShootCooldown = 1.35

var patrol_down = true
var shoot_timer
var dead = false

# alien.gd

# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_timer = ShootCooldown

func charge_up():
	$AnimationPlayer.play("ChargeUp")

func shoot():
	if not player:
		return
	var instance = Bloop.instance()
	instance.position = position
	instance.set_up(player)
	get_parent().add_child(instance)
	

func _process(delta):
	if dead:
		return
	var desired_y = global_position.y
	if player:
		shoot_timer -= delta
		if shoot_timer < 0:
			shoot_timer = ShootCooldown
			charge_up()
		desired_y = player.global_position.y - Offset
		look_at(player.position)
	else:
		if patrol_down:
			if global_position.y <= MinHeight:
				patrol_down = false
			else:
				desired_y = MinHeight
		else:
			if global_position.y >= MaxHeight:
				patrol_down = true
			else:
				desired_y = MaxHeight
	global_position.y = move_toward(global_position.y, desired_y, Speed * delta)

func die():
	dead = true
	$AnimationPlayer.play("Die")

func destroy():
	var instance = Blood.instance()
	instance.position = position
	get_parent().add_child(instance)
	queue_free()

func _on_Scanner_body_entered(body):
	if not body.is_in_group("player"):
		return;
	player = body



func _on_Scanner_body_exited(body):
	if not body.is_in_group("player"):
		return;
	player = null




