extends KinematicBody2D



var direction = 1

const Speed = 20

const Blood = preload("res://Scenes/Blood.tscn")

var motion = Vector2()

var target = null
var target_exited = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Idle")


func _physics_process(delta):
	if target and not target_exited:
		if target.position.x < position.x:
			$Sprite.flip_h = true;
		else:
			$Sprite.flip_h = false;
		return;
	
	
	motion.x = direction * Speed
	if direction == 1:
		$Sprite.flip_h = false;
	else:
		$Sprite.flip_h = true;
	
	move_and_slide(motion)

func try_attack():
	if target_exited:
		return
	else: 
		target.take_damage()

func die():
	destroy()

func destroy():
	var instance = Blood.instance()
	instance.position = position
	if owner:
		owner.add_child(instance);
	else:
		get_parent().add_child(instance)
	queue_free()

func _on_RightTrigger_body_exited(body):
	direction = -1

func _on_AttackTrigger_body_exited(body):
	target_exited = true


func _on_LeftTrigger_body_exited(body):
	direction = 1


func _on_AttackTrigger_body_entered(body):
	target = body
	target_exited = false
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("Attack")



