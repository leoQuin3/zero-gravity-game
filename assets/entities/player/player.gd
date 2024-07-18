extends CharacterBody3D
class_name Player

# Parameters
@export var MAX_SPEED: float = 7
@export var THRUST_SPEED: float = 100
@export var DAMPING: float = 1
@export var MOUSE_IS_CAPTURED: bool = true
@export var CAMERA_SENSITIVITY: float = 0.003
@export var cameraHead: Node3D

# TODO: Transition player logic to different states. Figure how to transfer variables from
# player.gd to the state scripts under PlayerFSM

func _ready() -> void:
	if MOUSE_IS_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta) -> void:
	# Calculate direction vector from keys and camera orientation
	#var inputVector: Vector2 = Input.get_vector("left", "right", "forward", "back")
	#var newDirection: = (cameraHead.global_transform.basis * Vector3(inputVector.x, 0 , inputVector.y)).normalized()
	
	# Accelerate player
	#if inputVector:
		#velocity += newDirection * THRUST_SPEED * delta
	#
	## Enforce maximum velocity
	#if velocity.length() > MAX_SPEED:
		#velocity = velocity.normalized() * MAX_SPEED
	
	# Update player physics
	move_and_slide()
