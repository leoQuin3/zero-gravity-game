extends State

#TODO: Implement the following:
#	1) Dash around using "dash" action

@export var player: Player
@export var cameraHolder: Node3D
@export var weaponInventory: Node3D
@export var grappleHolder: GrapplingHook

var targetPosition: Vector3
var canCancel: bool = false

# Set mouse capture
func initialize() -> void:
	if cameraHolder.MOUSE_IS_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
# Set target position
func enter() -> void:
	grappleHolder.grappleCursor.show() #FIXME: Use signals to call instead.
	targetPosition = grappleHolder.get_grapple_point()
	canCancel = false

# Reset grapple holder's orientation
func exit() -> void:
	grappleHolder.grappleCursor.hide() #FIXME: Use signals to call instead.
	grappleHolder.rotation = Vector3.ZERO
	canCancel = false
	
# Update every frame
func update(delta) -> void:
	#Change state when within range of target position
	if player.global_position.distance_to(targetPosition) < grappleHolder.cancelDistance:
		emit_signal("state_transitioned", "FLOATING")
	
	# Update cursor on screen
	grappleHolder.update_cursor_position(targetPosition)

# Grapple and strafe
func update_physics(delta) -> void:
	grappleHolder.grapple_towards(player, targetPosition)
	grappleHolder.player_grapple_strafe(player, targetPosition)
	
# Handle mouse input
func handle_input(event) -> void:
	# Look around
	if event is InputEventMouseMotion:
		cameraHolder.fp_camera_look(event, deg_to_rad(-90), deg_to_rad(90))
		
	# Equip and use weapon
	if event is InputEventMouseButton and event.is_pressed():
		weaponInventory.scroll_weapon_select(event)
		weaponInventory.fire_weapon(event)
	
	# Cancel grappling
	if Input.is_action_just_pressed("grapple"):
		emit_signal("state_transitioned", "FLOATING")
