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
	if event is InputEventMouseMotion:
		parent.fp_camera_look(event, deg_to_rad(-90), deg_to_rad(90))
	if event is InputEventMouseButton and event.is_pressed():
		parent.scroll_weapon_index(event)
		if event.button_index == MOUSE_BUTTON_LEFT:
			parent.fire_weapon()
