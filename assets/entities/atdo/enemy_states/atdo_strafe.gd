extends State

@export var enemy: ATDO
@export var detectionArea: Area3D
@export var stateTimer: Timer

var player: Player
var strafeVector: Vector3

func enter() -> void:
	# Get player, if detected
	if detectionArea.player:
		self.player = detectionArea.player
	
	# Otherwise, return to IDLE
	else:
		emit_signal("state_transitioned", "IDLE")
		return
	
	# Initialize direction
	strafeVector = enemy.transform.basis.x * enemy.speed * random_sign()
	
	# Start state timer
	stateTimer.wait_time += randf_range(0, 1)
	stateTimer.start()

func update(delta) -> void:
	enemy.look_at(player.global_position)

func update_physics(delta) -> void:
	enemy.velocity = strafeVector * delta

func _on_strafe_state_timer_timeout():
	emit_signal("state_transitioned", "ATTACK")

func random_sign():
	randomize()
	if randi() % 2 == 0:
		return 1
	else:
		return -1
