extends CharacterBody3D
class_name Player

# Parameters
@export var MAX_SPEED: float = 7
@export var THRUST_SPEED: float = 100

@export_category("Connect Nodes")
@export var cameraHead: Node3D

# Update player physics.
func _physics_process(delta) -> void:
	move_and_slide()

# Move in all directions using input keys. Always facing in camera's direction.
func player_control_move(delta: float):
	# Calculate direction vector from keys and camera orientation
	var inputVector: Vector2 = Input.get_vector("left", "right", "forward", "back")
	var newDirection: = (cameraHead.global_transform.basis * Vector3(inputVector.x, 0 , inputVector.y)).normalized()
	
	# Accelerate player
	if inputVector:
		velocity += newDirection * THRUST_SPEED * delta
	
	# Enforce maximum velocity
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED
