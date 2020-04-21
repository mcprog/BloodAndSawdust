extends CanvasLayer





func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Help_pressed():
	get_tree().change_scene("res://Scenes/HelpMenu.tscn")


func _on_Credits_pressed():
	get_tree().change_scene("res://Scenes/CreditsMenu.tscn")
