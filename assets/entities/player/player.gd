extends CharacterBody3D

class_name Player

@export var MAX_SPEED: float = 7
@export var CAMERA_SENSITIVITY: float = 0.003
@export var MOUSE_IS_CAPTURED: bool = true
@export var cameraHead: Node3D

@export var THRUST_SPEED: float = 100
const DAMPING: float = 0.5

func _ready():
	if MOUSE_IS_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# TODO: make player as state machine
	# If GROUNDED: snap to floor or wall
	#	move across floor or wall
	#	if jumping, set state to FLOATING
	# If FLOATING: 
	#	move around freely
	#	if touching floor, set state to GROUNDED
	
	# Calculate direction vector from keys and camera orientation
	var inputVector: Vector2 = Input.get_vector("left", "right", "forward", "back")
	var newDirection: = (cameraHead.global_transform.basis * Vector3(inputVector.x, 0 , inputVector.y)).normalized()
	
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
