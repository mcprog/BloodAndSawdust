extends RigidBody2D


const SawTime = .5

# falling crate.gd

const Epsilon = .001
const SleepTime = .5

var saw_timer = -1;
var frozen;
var sleep_timer= SleepTime

func start_sawing():
	saw_timer = 0
	$AnimationPlayer.play("Breaking")

func stop_sawing():
	saw_timer = -1
	$AnimationPlayer.stop()

func die():
	$AnimationPlayer.play("BreakFalling")

func destroy():
	var instance = $Sawdust.duplicate()
	instance.visible = true
	instance.global_position = $Sawdust.global_position
	get_parent().add_child(instance)
	queue_free()

func _process(delta):
	if sleep_timer > 0:
		sleep_timer -= delta
		return
	
	if saw_timer >= 0:
		saw_timer += delta
	if saw_timer >= SawTime:
		die()
	if not frozen and abs(linear_velocity.y) < Epsilon:
		frozen = true;
		mode = RigidBody2D.MODE_STATIC
		


func _on_FallingCrate_body_entered(body):
	frozen = true;
	mode = RigidBody2D.MODE_STATIC
	print("mode is static")
