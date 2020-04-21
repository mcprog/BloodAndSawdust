extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const LockedText = "Locked"
const UnlockedText = "'E'"

var locked = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") and not locked:
		$SpriteOpen.visible = false
		$AnimationPlayer.play("Transition")
		
func change_scene():
	get_tree().change_scene("res://Scenes/EndScreen.tscn")

func _on_Door_body_entered(body):
	if not body.is_in_group("player"):
		return;
	if body.has_key:
		$Label.text = UnlockedText
		locked = false;
	else:
		$Label.text = LockedText
		locked = true;
	
	$AnimationPlayer.play("Show")


func _on_Door_body_exited(body):
	if not body.is_in_group("player"):
		return;
	$AnimationPlayer.play("Hide")
