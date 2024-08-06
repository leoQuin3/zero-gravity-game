# Base class for all enemies. Methods may be overridden.
extends CharacterBody3D
class_name ATDO

#TODO: Add ATDO and other enemies to node group "Enemies"

# Parameters
@export var SPEED: float = 150.0

# Update physics
func _physics_process(delta):
	move_and_slide()
	
# Move toward Player
func follow_player(playerPosition: Vector3, delta: float) -> void:
	# Get direction vector and apply velocity
	var directionVector: Vector3 = (playerPosition - self.global_position).normalized()
	self.velocity = directionVector * SPEED * delta

