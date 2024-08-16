extends State

@export var enemy: ATDO
@export var detection: Area3D
@export var raycast: RayCast3D
@export var weapon: Node3D

@export var stateTimer: Timer
@export var cooldownTimer: Timer

var player: Player

#TODO: Let enemy shoot ONLY IF in line of sight (ie. raycast is detecting Player)

# Connect detection area's signal
func initialize() -> void:
	detection.connect("player_detected", Callable(self, "on_player_detected"))

# Get player
func on_player_detected(player) -> void:
	self.player = player

# Update orientation
func update(delta) -> void:
	enemy.look_at(player.global_position)
	
# Initialize
func enter() -> void:
	enemy.look_at(player.global_position)
	enemy.velocity = Vector3.ZERO
	
	# Start timers
	stateTimer.start()
	cooldownTimer.start()

# Stop cooldownTimer when exiting state
func exit():
	cooldownTimer.stop()

# Fire again after cooldown, if state timer is still running
func _on_cooldown_timeout():
	if !stateTimer.is_stopped():
		weapon.fire()

# Change state
func _on_attack_state_timeout():
	emit_signal("state_transitioned", "CHASE")

