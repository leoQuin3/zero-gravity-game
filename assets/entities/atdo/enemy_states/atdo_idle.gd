extends State

@export var enemy: ATDO
@export var detectionArea: Area3D
@export var directionTimer: Timer

var direction: Vector3 = Vector3(0, 0, 0)
var speed: float

#TODO: Implement raycasts to avoid obstacles

func initialize() -> void:
	detectionArea.connect("player_detected", Callable(self, "on_player_detected"))
	speed = enemy.speed
	direction = randomize_vector()

# Set parameters and start timer
func enter() -> void:
	detectionArea.connect("player_detected", Callable(self, "on_player_detected"))
	directionTimer.start()

# Stop timer when leaving state
func exit() -> void:
	directionTimer.stop()
	detectionArea.disconnect("player_detected", Callable(self, "on_player_detected"))

# Update physics
func update_physics(delta) -> void:
	enemy.velocity = direction * speed * delta

# Randomly change direction upon timeout
func _on_direction_timer_timeout():
	direction = randomize_vector()

# Change state
func on_player_detected(body):
	emit_signal("state_transitioned", "CHASE")

func randomize_vector():
	return Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized()
