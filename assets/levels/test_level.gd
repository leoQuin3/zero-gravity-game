extends Node3D

# Exit game
func _input(event):
	if event is InputEvent and event.is_action_pressed("ui_cancel"):
		get_tree().quit()
