# Base class for all enemies. Methods may be overridden.
extends CharacterBody3D
class_name ATDO

# Parameters
@export var SPEED: float = 150.0
@export var weaponHolder: Node3D
var health: int = 100

#NOTE: Maybe create base class for all enemies? First implement ATDO, and figure out from there.
#TODO: Add ATDO and other enemies to node group "Enemies"

# Update physics
func _physics_process(delta):
	move_and_slide()
	
# Move toward Player
func chase_player(playerPosition: Vector3, delta: float) -> void:
	# Get direction vector and apply velocity
	var directionVector: Vector3 = (playerPosition - self.global_position).normalized()
	self.velocity = directionVector * SPEED * delta

# Attack player
func attack_player(playerPosition: Vector3, delta: float) -> void:
	print("PEW PEW PEW")

# Idle
func idle(delta: float) -> void:
	#TODO: Randomly wonder, using timer to change direction
	pass
