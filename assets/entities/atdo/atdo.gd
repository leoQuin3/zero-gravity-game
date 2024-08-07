# Base class for all enemies. Methods may be overridden.
extends CharacterBody3D
class_name ATDO

#TODO: Add ATDO and other enemies to node group "Enemies"

# Parameters
@export var speed: float = 200.0
@export var navRaycasts: Node3D

# Update physics
func _physics_process(delta):
	move_and_slide()

# Aim raycasts toward direction, parallel to floor
func _process(delta):
	var lookAngle: float = atan2(self.velocity.x, self.velocity.z) + PI
	navRaycasts.rotation.y = lookAngle

# Move toward Player
func follow_player(playerPosition: Vector3, delta: float) -> void:
	# Get direction vector and apply velocity
	var directionVector: Vector3 = (playerPosition - self.global_position).normalized()
	self.velocity = directionVector * speed * delta

# Delete enemy when health runs out
func _on_health_health_ran_out():
	queue_free()
