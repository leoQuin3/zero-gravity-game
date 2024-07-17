extends CharacterBody3D

class_name Player

# Parameters
@export_category("Physics Settings")
@export var MAX_SPEED: float = 7
@export var THRUST_SPEED: float = 100
@export var DAMPING: float = 0.5

@export_category("Mouse Settings")
@export var MOUSE_IS_CAPTURED: bool = true
@export var CAMERA_SENSITIVITY: float = 0.003

@export_category("Connecting Nodes")
@export var cameraHead: Node3D

func _ready():
	if MOUSE_IS_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# Calculate direction vector from keys and camera orientation
	var inputVector: Vector2 = Input.get_vector("left", "right", "forward", "back")
	var newDirection: = (cameraHead.global_transform.basis * Vector3(inputVector.x, 0 , inputVector.y)).normalized()
	
	# TODO: make player as state machine
	# If GROUNDED:
	#	snap and move across floor or wall
	#	if jumping, set state to FLOATING
	#	if using grappling hook, set state to LAUNCHING
	# If FLOATING:
	#	move around freely
	#	if touching floor, set state to GROUNDED
	#	if using grappling hook, set state to LAUNCHING
	# If LAUNCHING:
	#	move toward target with little influence from player movement
	#	if touching floor, set state to GROUNDED
	#	if timer runs out or player dashes, set state to FLOATING
	
	# TODO: Add following part of state FLOATING after implementing state machine
	# Accelerate player
	if inputVector:
		velocity += newDirection * THRUST_SPEED * delta
	
	# Enforce maximum velocity
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED
	
	# Update player physics
	move_and_slide()

# Handle mouse input
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var newPitch = event.relative.y
		var newYaw = event.relative.x
		cameraHead.rotation.x -= newPitch * CAMERA_SENSITIVITY
		self.rotation.y -= newYaw * CAMERA_SENSITIVITY
