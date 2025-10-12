extends CharacterBody3D
class_name Player

# Parameters
const MAX_SPEED: float = 10
const THRUST_SPEED: float = 100

@export_category("Connect Nodes")
@export var cameraHolder: CameraHolder

# Update player physics.
func _physics_process(delta) -> void:
	move_and_slide()

# Player movement
#FIXME: may need to handle case if cameraHolder doesn't exist
func player_control_move(delta: float):
	var inputVector: Vector2 = Input.get_vector("left", "right", "forward", "back")
	var newDirection: = (cameraHolder.global_transform.basis * Vector3(inputVector.x, 0 , inputVector.y)).normalized()
	
	if inputVector:
		velocity += newDirection * THRUST_SPEED * delta
	else:
		velocity = lerp(velocity, Vector3.ZERO, 0.05)
	
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED
