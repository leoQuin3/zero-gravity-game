extends State

@export var enemy: ATDO
@export var raycast: RayCast3D
@export var stateTimer: Timer
@export var detectionArea: Area3D

var direction: Vector3
var player: Player
const maxPlayerDist: int = 30

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
	
	# Begin state timer
	stateTimer.start()
	
	#TEMP: Debug chase
	print("Chasing")
	
# Look at and follow player
func update_physics(delta) -> void:
	enemy.follow_player(player.global_position, delta)
	enemy.look_at(player.global_position)

# When state timer finishes
func _on_chase_state_timer_timeout():
	# If player is too far, move toward player
	if enemy.global_position.distance_squared_to(player.global_position) > maxPlayerDist ** 2:
		emit_signal("state_transitioned", "CHASE")
	
	# Otherwise, strafe
	else:
		emit_signal("state_transitioned", "STRAFE")
