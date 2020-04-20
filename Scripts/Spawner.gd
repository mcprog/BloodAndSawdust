extends Node2D

const AlienCool = 5;
const CrateCool = 9;
const MinX = -190;
const MaxX = 450;
const StartY = -400;

const Alien = preload("res://Scenes/Alien.tscn")
const Crate = preload("res://Scenes/FallingCrate.tscn")

var alien_timer;
var crate_timer;
# Called when the node enters the scene tree for the first time.
func _ready():
	crate_timer = CrateCool
	alien_timer = AlienCool
	randomize()

func spawn_crate():
	var instance = Crate.instance()
	var rand_x = rand_range(MinX, MaxX)
	instance.position = Vector2(rand_x, StartY)
	add_child(instance)
	print("spawned child of spawner (crate)")

func spawn_alien():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	crate_timer -= delta
	alien_timer -= delta
	if crate_timer < 0:
		spawn_crate();
		crate_timer = CrateCool
	if alien_timer < 0:
		spawn_alien();
		alien_timer = AlienCool
