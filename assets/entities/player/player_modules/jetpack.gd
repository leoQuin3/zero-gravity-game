# Module Allows the player to dash
extends Node3D
class_name Jetpack

@export var player: Player
@export var dashSpeed: float = 40
@export var dashThrustSpeed: float = 400

@export_category("Connect Nodes")
@export var dashTimer: Timer
@export var dashCooldownTimer: Timer

@onready var defaultSpeed: float = player.speed
@onready var defaultThrustSpeed: float = player.thrustSpeed

var isDashing: bool = false
var canDash: bool = true

# Dash
func player_dash():
	# If unable to dash, don't continue
	if !canDash:
		return
	
	# Increase speed
	player.speed = dashSpeed
	player.thrustSpeed = dashThrustSpeed
	isDashing = true
	canDash = false
	
	# Begin timer
	dashTimer.start()

# Restore speed
func _on_dash_timer_timeout():
	# Restore speed
	player.speed = defaultSpeed
	player.thrustSpeed = defaultThrustSpeed
	isDashing = false
	
	# Start cooldown timer
	dashCooldownTimer.start()

# Allow player to dash again
func _on_dash_cooldown_timeout():
	canDash = true
