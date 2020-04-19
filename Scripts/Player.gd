extends KinematicBody2D

var motion = Vector2()

const Gravity = 8

export(float) var speed = 85
export(float) var jump = -230
export(int) var health = 10
export(int) var sawdust = 5;
export(int) var blood = 2;

var can_jump = false
var did_jump = false

onready var health_value = $HUD/MarginContainer/Stats/Health/Value
onready var sawdust_value = $HUD/MarginContainer/Stats/Sawdust/Value
onready var blood_value = $HUD/MarginContainer/Stats/Blood/Value

func _ready():
	health_value.text = str(health)
	sawdust_value.text = str(sawdust)
	blood_value.text = str(blood)

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
	
	if Input.is_action_pressed("attack"):
		$Saw.show()
	else:
		$Saw.hide()

func eat() -> bool:
	sawdust -= 1
	if sawdust < 0:
		return false
	sawdust_value.text = str(sawdust)
	return true

func drink() -> bool:
	blood -= 1
	if blood < 0:
		return false
	blood_value.text = str(blood)
	return true

func add_sawdust():
	$PickupSound.play()
	sawdust += 1;
	sawdust_value.text = str(sawdust)

func add_blood():
	$PickupSound.play()
	blood += 1
	blood_value.text = str(blood)
		
func die():
	queue_free()

func take_damage(amt = 1):
	health -= amt
	$AnimationPlayer.play("Hurt")
	add_blood()
	$HurtSound.play()
	if health <= 0:
		die()
	else:
		health_value.text = str(health)

func _physics_process(delta):
	motion.y += Gravity
	
	
	
	move_and_slide(motion, Vector2.UP)
