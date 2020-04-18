extends KinematicBody2D

var motion = Vector2()

const Gravity = 8

export(float) var speed = 85
export(float) var jump = -230
export(int) var health = 10

var can_jump = false
var did_jump = false

onready var health_value = $HUD/MarginContainer/HBoxContainer/HealthValue

func _process(delta):
	motion.x = 0
	if Input.is_action_pressed("right"):
		motion.x = speed
	elif Input.is_action_pressed("left"):
		motion.x = -speed
	
	if motion.x < 0:
		$Sprite.flip_h = true
	elif motion.x > 0:
		$Sprite.flip_h = false
	
	if is_on_floor():
		can_jump = true
		motion.y = 0
		did_jump = false
	else:
		can_jump = false
	
	if Input.is_action_pressed("jump") and can_jump and not did_jump:
		motion.y = jump
		did_jump = true

		
func die():
	queue_free()

func take_damage():
	health -= 1
	$AnimationPlayer.play("Hurt")
	if health <= 0:
		die()
	else:
		health_value.text = str(health)

func _physics_process(delta):
	motion.y += Gravity
	
	
	
	move_and_slide(motion, Vector2.UP)
