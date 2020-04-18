extends Node2D


const Water = preload("res://Scenes/Water.tscn")

const Offset = 79

const MaxWaveNumber = 20

var wave_number
# Called when the node enters the scene tree for the first time.
func _ready():
	#while get_child_count() < MaxWaveNumber:
	#	add_wave()
	pass


func add_wave():
	var new_wave = Water.instance()
	new_wave.position = get_children()[get_child_count() - 1].position
	new_wave.position.x += Offset
	add_child(new_wave)

func _process(delta):
	if get_child_count() < MaxWaveNumber:
		add_wave()
		
		
