extends Area2D


# sawdust.gd


func _ready():
	pass # Replace with function body.



func die():
	queue_free()

func _on_Sawdust_body_entered(body):
	if not body.is_in_group("player"):
		return
	body.add_sawdust()
	die()
	
