extends CanvasLayer



func show():
	$MarginContainer.visible = true

func _on_Retry_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Quit_pressed():
	get_tree().quit()
