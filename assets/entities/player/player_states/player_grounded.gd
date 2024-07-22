# In state FLOATING, the player can move freely under zero gravity.
extends State

@export var parent: Player
@export var cameraHolder: Node3D
@export var weaponHolder: Node3D

func enter() -> void:
	pass

func exit() -> void:
	pass

func initialize() -> void:
	if cameraHolder.MOUSE_IS_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func update(delta) -> void:
	pass
	
func update_physics(delta) -> void:
	parent.player_control_move(delta)
	
func handle_input(event) -> void:
	# Handle mouse input
	if event is InputEventMouseMotion:
		cameraHolder.fp_camera_look(event, deg_to_rad(-90), deg_to_rad(90))
		
	# Handle mouse click
	if event is InputEventMouseButton and event.is_pressed():
		weaponHolder.scroll_weapon_index(event)
		if event.button_index == MOUSE_BUTTON_LEFT:
			weaponHolder.fire_weapon()
