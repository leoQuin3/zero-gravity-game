# Base class for all enemies. Methods may be overridden.
extends CharacterBody3D
class_name ATDO

@export var SPEED: float = 150.0

#NOTICE: Maybe create base class for all enemies. Focus on implementing other enemies, and figure out from there.
#TODO: Add ATDO and other enemies to node group "ENEMIES"

# Update physics
func _physics_process(delta):
	move_and_slide()

# Move toward Player
func chase_player(playerPosition: Vector3, delta: float) -> void:
	var directionVector: Vector3 = (playerPosition - self.global_position).normalized()
	
	# Set velocity
	self.velocity = directionVector * SPEED * delta

# Attack player
func attack_player(playerPosition: Vector3, delta: float) -> void:
	print("PEW PEW PEW")

# Idle
func idle(delta: float) -> void:
	pass
