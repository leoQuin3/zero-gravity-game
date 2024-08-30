extends State

@export var enemy: ATDO
@export var raycast: RayCast3D
@export var weapon: Node3D
@export var detectionArea: Area3D

@export var stateTimer: Timer
@export var cooldownTimer: Timer

var player: Player
const maxPlayerDist: int = 30

#TODO: Play animation when entering state and shooting

# Initialize state
func enter() -> void:
	# Get player, if detected
	if detectionArea.player:
		self.player = detectionArea.player
	
	# Freeze and look at player
	enemy.velocity = Vector3.ZERO
	enemy.look_at(player.global_position)
	
	# Start timers
	stateTimer.start()
	cooldownTimer.start()
	
	# Fire weapon
	weapon.fire()
	
# Stop cooldownTimer when exiting state
func exit():
	cooldownTimer.stop()

# Focus at player
func update(delta) -> void:
	enemy.look_at(player.global_position)

# Fire again after cooldown
func _on_cooldown_timeout():
	weapon.fire()

# Change state
func _on_attack_state_timeout():
	# If player is far away, move toward player
	if enemy.global_position.distance_squared_to(player.global_position) > maxPlayerDist ** 2:
		emit_signal("state_transitioned", "CHASE")
	
	# Otherwise, move to the side
	else:
		emit_signal("state_transitioned", "STRAFE")
