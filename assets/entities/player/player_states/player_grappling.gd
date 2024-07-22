extends State

@export var player: Player
@export var grappleHook: GrapplingHook
@export var weaponHolder: Node3D
@export var cameraHolder: Node3D

var targetPosition: Vector3

func enter():
	grappleHook.grapple(player)

func initialize() -> void:
	if cameraHolder.MOUSE_IS_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func update(delta) -> void:
	if player.is_on_floor() or player.is_on_wall() or player.is_on_ceiling():
		emit_signal("state_transitioned", "FLOATING")

func update_physics(delta) -> void:
	if grappleHook.can_grapple() and Input.is_action_just_pressed("grapple"):
		grappleHook.grapple(player)
	
func handle_input(event) -> void:
	# Handle mouse input
	if event is InputEventMouseMotion:
		cameraHolder.fp_camera_look(event, deg_to_rad(-90), deg_to_rad(90))
		
	# Handle mouse click
	if event is InputEventMouseButton and event.is_pressed():
		weaponHolder.scroll_weapon_index(event)
		weaponHolder.fire_weapon(event)
