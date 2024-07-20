# In state FLOATING, the player can move freely under zero gravity.
extends State

@export var parent: Player

func enter() -> void:
	pass

func exit() -> void:
	pass

func initialize() -> void:
	if parent.MOUSE_IS_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func update(delta) -> void:
	pass
	
func update_physics(delta) -> void:
	parent.player_control_move(delta)
	
func handle_input(event) -> void:
	parent.fp_camera_look(event, deg_to_rad(-90), deg_to_rad(90))
	parent.scroll_weapon_index(event)
