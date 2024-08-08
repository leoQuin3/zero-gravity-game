extends State

@export var enemy: ATDO
@export var detectionArea: Area3D
@export var weapon: Node3D
@export var weaponTimer: Timer
@export var stateTimer: Timer

var player: Player

enum STATES {READY, FIRING}
var currentWeaponState: STATES

#TODO: 
#	1) Clean up code and improve enemy's attack behaviour (Refactor, rework signals better, etc)
#	2) BUG: ATDO will shoot and chase for inconsistent amount of seconds (check signals and cancel timers?)

# Connect detection area's signal
func initialize() -> void:
	detectionArea.connect("player_detected", Callable(self, "on_player_detected"))

# Initialize enemy and weapon
func enter() -> void:
	enemy.velocity = Vector3.ZERO
	currentWeaponState = STATES.READY
	
	# Start state timer
	stateTimer.start()

# Update weapon orientation
func update(delta) -> void:
	weapon.look_at(player.global_position)
	
	# If weapon is ready, fire
	if currentWeaponState == STATES.READY:
		weapon.fire()

# Get player
func on_player_detected(player) -> void:
	self.player = player

# Set weapon state to ready after cooldown
func _on_weapon_timer_timeout():
	currentWeaponState = STATES.READY

# Cooldown after firing
func _on_weapon_shots_fired():
	currentWeaponState = STATES.FIRING
	weaponTimer.start()

# Switch state after state timer runs out
func _on_attack_time_timeout():
	emit_signal("state_transitioned", "CHASE")
