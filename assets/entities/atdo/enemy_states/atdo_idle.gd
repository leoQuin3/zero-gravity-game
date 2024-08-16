extends State

@export var enemy: ATDO
@export var detection: Area3D
@export var directionTimer: Timer

var direction: Vector3 = Vector3(0, 0, 0)
var speed: float

#FIXME: Find other way to pass in player from one state to another

# Connect detection area's signal and speed
func initialize() -> void:
	detection.connect("player_detected", Callable(self, "on_player_detected"))
	speed = enemy.speed

# Set parameters and start timer
func enter() -> void:
	directionTimer.start()
	direction = randomize_vector()

# Stop timer when leaving state
func exit() -> void:
	directionTimer.stop()
	detection.disconnect("player_detected", Callable(self, "on_player_detected"))

# Update physics
func update_physics(delta) -> void:
	enemy.velocity = direction * speed * delta

# Randomly change direction upon timeout
func _on_direction_timer_timeout():
	direction = randomize_vector()
	directionTimer.wait_time = randf_range(0.5, 2)

# Change state
func on_player_detected(body):
	emit_signal("state_transitioned", "ATTACK")

# Generate random vector (normalized)
func randomize_vector():
	randomize()
	return Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized()
