extends CharacterBody3D
class_name Player

#TODO: Use component to give player Dashing ability instead of hard coding it.

# Parameters
@export var speed: float = 10
@export var thrustSpeed: float = 100
@export var dashSpeed: float = 3

var defaultSpeed: float = speed
var defaultThrustSpeed: float = thrustSpeed

var isDashing: bool = false
var canDash: bool = true

@export_category("Connect Nodes")
@export var cameraHead: Node3D
@export var dashTimer: Timer
@export var dashCooldownTimer: Timer

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
		velocity += newDirection * thrustSpeed * delta
	
	# Enforce maximum velocity
	if velocity.length() > speed:
		velocity = velocity.normalized() * speed

func player_dash():
	# If cannot dash, terminate
	if !canDash:
		return
	
	# Increase speed
	speed = defaultSpeed * dashSpeed
	thrustSpeed = defaultThrustSpeed * dashSpeed
	isDashing = true
	canDash = false
	
	# Begin timer
	dashTimer.start()

func _on_dash_timer_timeout():
	# Restore speed
	speed = defaultSpeed
	thrustSpeed = defaultThrustSpeed
	isDashing = false
	
	# Start cooldown timer
	dashCooldownTimer.start()

func _on_dash_cooldown_timeout():
	canDash = true
