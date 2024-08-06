extends State

@export var SPEED: float = 10

@export var detectionArea: Area3D
@export var directionTimer: Timer
@export var enemy: ATDO

var direction: Vector3

func initialize() -> void:
	detectionArea.connect("player_detected", Callable(self, "on_player_detected"))

func enter() -> void:
	direction = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized()
	
	directionTimer.start()
	
func exit() -> void:
	pass

func update(delta) -> void:
	pass

# TODO: Wonder randomly
func update_physics(delta) -> void:
	enemy.velocity = direction * SPEED * delta
	pass

func on_player_detected(player: Player):
	print(str(player) + " has been detected!")
	emit_signal("state_transitioned", "CHASE")

func _on_direction_timer_timeout():
	direction = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1))
