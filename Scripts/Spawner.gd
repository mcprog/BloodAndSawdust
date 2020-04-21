extends Node2D

const AlienCool = 9;
const CrateCool = 9;
const MaxCrates = 10;
const MaxAliens = 7;
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
	if $Crates.get_child_count() > MaxCrates:
		print("too many crates, aborting!")
		return;
	var instance = Crate.instance()
	var rand_x = rand_range(MinX, MaxX)
	instance.position = Vector2(rand_x, StartY)
	$Crates.add_child(instance)

func spawn_alien():
	if $Aliens.get_child_count() > MaxAliens:
		print("too many aliens, aborting!")
		return;
	var instance = Alien.instance()
	var rand_x = rand_range(MinX, MaxX)
	instance.position = Vector2(rand_x, StartY)
	$Aliens.add_child(instance)
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
