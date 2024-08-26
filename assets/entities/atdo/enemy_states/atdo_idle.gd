extends State

@export var enemy: ATDO
@export var detectionArea: Area3D
@export var directionTimer: Timer

var direction: Vector3 = Vector3(0, 0, 0)
var speed: float

# Initialize properties
func initialize() -> void:
	speed = enemy.speed

# Initialize state properties
func enter() -> void:
	# Initialize direction
	direction = randomize_vector()
	
	# Start timers
	directionTimer.start()
	
# Stop timer when leaving state
func exit() -> void:
	directionTimer.stop()

# Update physics
func update_physics(delta) -> void:
	enemy.velocity = direction * speed * delta

# Randomly change direction upon timeout
func _on_direction_timer_timeout():
	directionTimer.wait_time = randf_range(0.5, 2)
	direction = randomize_vector()

# Generate random vector (normalized)
func randomize_vector():
	randomize()
	return Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized()

func _on_detection_player_detected():
	emit_signal("state_transitioned", "ATTACK")
	detectionArea.disconnect("player_detected", Callable(self, "_on_detection_player_detected"))
