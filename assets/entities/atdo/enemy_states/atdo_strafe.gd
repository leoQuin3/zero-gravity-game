# Strafe in opposite direction of player
extends State

@export_category("Connect Nodes")
@export var enemy: ATDO
@export var detectionArea: Area3D
@export var stateTimer: Timer

@onready var speed: float = enemy.speed
var player: Player

func enter() -> void:
	# Get player, if detected
	if detectionArea.player:
		self.player = detectionArea.player
	
	# Otherwise, return to IDLE
	else:
		emit_signal("state_transitioned", "IDLE")
		return
	
	# Start state timer
	stateTimer.wait_time += randf_range(0, 1)
	stateTimer.start()

# Strafe
func update_physics(delta) -> void:
	# Get projection of distance onto enemy x-basis vector
	var distanceVector = player.global_position - enemy.global_position
	var strafeProjection = distanceVector.project(enemy.transform.basis.x)
	const strafeThreshhold: float = 1
	
	if strafeProjection.length() > strafeThreshhold:
		enemy.velocity = -strafeProjection.normalized() * speed * delta
	
# Switch state
func _on_strafe_state_timer_timeout():
	emit_signal("state_transitioned", "ATTACK")
