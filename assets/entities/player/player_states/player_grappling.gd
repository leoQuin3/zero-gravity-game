extends State

@export var player: Player
@export var grappleHook: GrapplingHook
@export var weaponHolder: Node3D
@export var cameraHolder: Node3D

var targetPosition: Vector3

# Set mouse capture
func initialize() -> void:
	if cameraHolder.MOUSE_IS_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
# Set target position
func enter() -> void:
	targetPosition = grappleHook.get_grapple_point()

# Reset grapple holder's orientation
func exit() -> void:
	grappleHook.rotation = Vector3.ZERO
	
# Switch state to FLOATING if colliding
func update(delta) -> void:
	#FIXME: Transition state when within certain distance from target position.
	if player.is_on_floor() or player.is_on_wall() or player.is_on_ceiling():
		emit_signal("state_transitioned", "FLOATING")

# Grapple and strafe
func update_physics(delta) -> void:
	grappleHook.grapple(player, targetPosition)
	grappleHook.player_grapple_strafe(player, targetPosition)
	
# Handle mouse input
func handle_input(event) -> void:
	# Look around
	if event is InputEventMouseMotion:
		cameraHolder.fp_camera_look(event, deg_to_rad(-90), deg_to_rad(90))
		
	# Shoot and select weapon
	if event is InputEventMouseButton and event.is_pressed():
		weaponHolder.scroll_weapon_index(event)
		weaponHolder.fire_weapon(event)
	
	#FIXME: Maybe add timer to prevent cancelling too early.
	## Cancel grappling
	#if Input.is_action_pressed("grapple"):
		#emit_signal("state_transitioned", "FLOATING")
