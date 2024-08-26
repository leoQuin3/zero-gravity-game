# In state FLOATING, the player can move freely under zero gravity.
extends State

#TODO: Define dash() function to allow player to quickly strafe

@export var player: Player
@export var cameraHolder: Node3D
@export var weaponInventory: Node3D
@export var grappleHolder: GrapplingHook

func initialize() -> void:
	if cameraHolder.MOUSE_IS_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func update_physics(delta) -> void:
	player.player_control_move(delta, player.maxSpeed)
	
func handle_input(event) -> void:
	# Look around
	if event is InputEventMouseMotion:
		cameraHolder.fp_camera_look(event, deg_to_rad(-90), deg_to_rad(90))
		
	# Equip and use weapon
	if event is InputEventMouseButton and event.is_pressed():
		weaponInventory.scroll_weapon_select(event)
		weaponInventory.fire_weapon(event)
	
	# Grapple
	if grappleHolder.can_grapple() and Input.is_action_just_pressed("grapple"):
		emit_signal("state_transitioned", "GRAPPLING")
