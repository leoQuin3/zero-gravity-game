extends State

@export var enemy: ATDO
@export var raycast: RayCast3D
@export var stateTimer: Timer
@export var detectionArea: Area3D

var direction: Vector3
var player: Player
const maxPlayerDist: int = 25

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
	stateTimer.start()
	
	print("Chasing")
	
# Process physics
func update_physics(delta) -> void:
	# Move towards player
	enemy.follow_player(player.global_position, delta)
	
	# Look at player
	enemy.look_at(player.global_position)

# When state timer finishes
func _on_chase_state_timer_timeout():
	# If player is far away, move toward player
	if enemy.global_position.distance_squared_to(player.global_position) > maxPlayerDist ** 2:
		emit_signal("state_transitioned", "CHASE")
	# Otherwise, move to the side
	else:
		emit_signal("state_transitioned", "STRAFE")
