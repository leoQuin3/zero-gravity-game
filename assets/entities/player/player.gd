extends CharacterBody3D
class_name Player

# Parameters
@export var MAX_SPEED: float = 7
@export var THRUST_SPEED: float = 100
@export var MOUSE_IS_CAPTURED: bool = true
@export var CAMERA_SENSITIVITY: float = 0.003
@export var cameraHead: Node3D

# Update player physics
func _physics_process(delta) -> void:
	move_and_slide() #NOTE: Should the parent or the states be responsible for updating?

## Control camera rotation using mouse input. Pitch and yaw are passed in radians.
func fp_camera_look(event: InputEvent, minPitch: float, maxPitch: float):
	if event is InputEventMouseMotion:
		var newPitch = event.relative.y
		var newYaw = event.relative.x
		
		#Update camera pitch and player yaw
		cameraHead.rotation.x -= newPitch * CAMERA_SENSITIVITY
		self.rotation.y -= newYaw * CAMERA_SENSITIVITY
		
		# Cap camera pitch
		cameraHead.rotation.x = clamp(cameraHead.rotation.x, minPitch, maxPitch)

## Move in all directions using input keys. Always facing in camera's direction.
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
