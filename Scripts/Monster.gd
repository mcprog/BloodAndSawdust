extends Node2D


enum States {
	Patrolling, Angry, AttackingPlayer, AttackingEnemy
}

const EatBreak = 5
const DrinkBreak = 3

const ClosePlayer = 35
const FarPlayer = 100
const Epsilon = 7
const RotateSpeed = .75;
const MoveSpeed = 1.2
const RotateTime = 3

const Splinter = preload("res://Scenes/Splinter.tscn")

var player;
var state

var eat_timer
var drink_timer
var rotation_timer
var go_close

var latest_enemy = null
var enemies_in_range = 0

func _ready():
	randomize()
	player = get_parent()
	state = States.Patrolling;
	$AnimationPlayer.play("Pulse")
	drink_timer = DrinkBreak
	eat_timer = EatBreak
	rotation_timer = RotateTime
	go_close = true

func eat(delta):
	eat_timer -= delta
	if eat_timer < 0:
		if player.eat():
			$EatSound.play()
		else:
			get_angry()
		eat_timer = EatBreak

func drink(delta):
	drink_timer -= delta
	if drink_timer < 0:
		if player.drink():
			$DrinkSound.play()
		else:
			get_angry()
		drink_timer = DrinkBreak

func patrol(delta):
	rotation_timer -= delta
	if rotation_timer < 0:
		#choose new target rotation
		rotation_timer = RotateTime
		$RayCast2D.rotation = rand_range(0, PI * 2)
	else:
		$MonsterOrigin.rotation = lerp_angle($MonsterOrigin.rotation, $RayCast2D.rotation, delta * RotateSpeed)
	if go_close:
		var goal = $MonsterOrigin.position
		goal.x += ClosePlayer
		if abs(goal.x - $MonsterOrigin/MonsterBody.position.x) < Epsilon:
			go_close = false
		else:
			$MonsterOrigin/MonsterBody.position = lerp($MonsterOrigin/MonsterBody.position, goal, delta * MoveSpeed)
	else:
		var goal = $MonsterOrigin.position
		goal.x += FarPlayer
		if abs(goal.x - $MonsterOrigin/MonsterBody.position.x) < Epsilon:
			go_close = true
		else:
			$MonsterOrigin/MonsterBody.position = lerp($MonsterOrigin/MonsterBody.position, goal, delta * MoveSpeed)
	
func get_angry():
	$AngrySound.play()
	state = States.Angry
	$AnimationPlayer.play("ChargeUp")
	
	
func attack_player():
	var instance = Splinter.instance()
	instance.global_position = $MonsterOrigin/MonsterBody.global_position
	instance.set_up(player)
	player.owner.add_child(instance)
	state = States.Patrolling

func _process(delta):
	if state == States.Patrolling:
		eat(delta);
		drink(delta);
		patrol(delta);
	elif state == States.Angry:
		pass
		




func _on_Scanner_area_entered(area):
	enemies_in_range += 1;
	latest_enemy = area
#	if state == States.Patrolling:
#		state = States.AttackingEnemy


func _on_Scanner_area_exited(area):
	enemies_in_range -= 1;
	if enemies_in_range == 0:
		state = States.Patrolling
