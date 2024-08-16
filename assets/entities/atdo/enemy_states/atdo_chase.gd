extends State

@export var enemy: ATDO
@export var detection: Area3D
@export var raycast: RayCast3D
@export var stateTimer: Timer

var direction: Vector3
var player: Player

#TODO: Use raycast to move around obstacle

# Connect signals
func initialize():
	detection.connect("player_detected", Callable(self, "on_player_detected"))

# Get player
func on_player_detected(player):
	self.player = player

# Initialize state properties
func enter():
	# If player is non-existant, return to state IDLE
	if !player:
		emit_signal("state_transitioned", "IDLE")
		return
	
	# Begin state timer
	stateTimer.start()

# Process physics
func update_physics(delta) -> void:
	# Move towards player
	enemy.follow_player(player.global_position, delta)
	
	# Look at player
	enemy.look_at(player.global_position)

# When state timer finishes
func _on_chase_state_timer_timeout():
	if raycast.is_colliding() and raycast.get_collider() is Player:
		emit_signal("state_transitioned", "ATTACK")
	else:
		# Otherwise, keep chasing
		emit_signal("state_transitioned", "CHASE")

