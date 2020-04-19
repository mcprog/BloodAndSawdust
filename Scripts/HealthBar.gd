extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func update_value(new_value):
	$Value.text = str(new_value)
