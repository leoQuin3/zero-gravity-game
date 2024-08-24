extends State

@export var enemy: ATDO
@export var raycast: RayCast3D
@export var stateTimer: Timer
@export var detectionArea: Area3D

var direction: Vector3
var player: Player

#TODO: Figure how to establish navigation in 3D space.

# Initialize state properties
func enter():
	# Get player, if detected
	if detectionArea.player:
		self.player = detectionArea.player
	# Otherwise, return to IDLE
	else:
		emit_signal("state_transitioned", "IDLE")
		return
	
	# Begin state timer (with random time)
	stateTimer.wait_time += randf_range(0, 1)
	stateTimer.start()
	
# Process physics
func update_physics(delta) -> void:
	# Move towards player
	enemy.follow_player(player.global_position, delta)
	
	# Look at player
	enemy.look_at(player.global_position)

# When state timer finishes
func _on_chase_state_timer_timeout():
	# If raycast detects player, ATTACK
	if raycast.is_colliding() and raycast.get_collider() is Player:
		emit_signal("state_transitioned", "ATTACK")
	else:
		# Otherwise, keep chasing
		emit_signal("state_transitioned", "CHASE")
