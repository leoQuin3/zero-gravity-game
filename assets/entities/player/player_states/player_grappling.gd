extends State

@export var player: Player
@export var cameraHolder: Node3D
@export var weaponHolder: Node3D
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
	
# Switch state to FLOATING if colliding
func update(delta) -> void:
	#Change state when within range of target position
	if player.global_position.distance_to(targetPosition) < grappleHolder.cancelDistance:
		emit_signal("state_transitioned", "FLOATING")
	
	grappleHolder.update_cursor_position(targetPosition)

# Grapple and strafe
func update_physics(delta) -> void:
	grappleHolder.grapple(player, targetPosition)
	grappleHolder.player_grapple_strafe(player, targetPosition)
	
# Handle mouse input
func handle_input(event) -> void:
	# Look around
	if event is InputEventMouseMotion:
		cameraHolder.fp_camera_look(event, deg_to_rad(-90), deg_to_rad(90))
		
	# Shoot and select weapon
	if event is InputEventMouseButton and event.is_pressed():
		weaponHolder.scroll_weapon_index(event)
		weaponHolder.fire_weapon(event)
	
	# Cancel grappling
	#TODO: Maybe add timer to prevent cancelling too early?
	if Input.is_action_just_pressed("grapple"):
		emit_signal("state_transitioned", "FLOATING")
