# In state FLOATING, the player can move freely under zero gravity.
extends State

#TODO: Implement the following:
#	1) Dash around using "dash" action

@export var player: Player
@export var cameraHolder: Node3D
@export var weaponInventory: Node3D
@export var grappleHolder: GrapplingHook

func initialize() -> void:
	if cameraHolder.MOUSE_IS_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func update(delta) -> void:
	pass
	
func update_physics(delta) -> void:
	player.player_control_move(delta, player.MAX_SPEED)
	
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
