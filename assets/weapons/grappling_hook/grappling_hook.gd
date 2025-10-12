# This module allows the player to move toward a position.

extends Node3D
class_name GrapplingHook

@export var grappleSpeed: float = 25
@export var strafeSpeed: float = 1000

@export_category("Connect Nodes")
@export var raycast: RayCast3D
@export var grappleCursor: Sprite2D
@export var camera: Camera3D

# Get position to move towards
func get_grapple_point() -> Vector3:
	return raycast.get_collision_point()

# Determine whether raycast is touching anything
func can_grapple() -> bool:
	return raycast.is_colliding()

# Move player towards grappling position
func grapple_towards(player: Player, targetPosition: Vector3) -> void:
	var targetDirection: Vector3 = (targetPosition - player.position).normalized()
	player.velocity = targetDirection * grappleSpeed
	
# Allow player to strafe left and right
#BUG: If grapple_towards() isnt being called, player will dramatically accelerate
func player_grapple_strafe(player:Player, targetPosition: Vector3, delta):
	self.look_at(targetPosition, Vector3.UP)
	
	var inputAxis: int = Input.get_axis("left", "right")
	var directionVector: Vector3 = (self.global_transform.basis * Vector3(inputAxis, 0, 0)).normalized()
	
	if inputAxis:
		player.velocity += (directionVector * strafeSpeed * delta)

# Show cursor where player is moving towards
func update_cursor_position(targetPosition: Vector3):
	var targetDirection: = (targetPosition - self.global_position)
	var playerDirection: = self.camera.global_transform.basis.z
	
	var perpDotProduct: float = targetDirection.dot(playerDirection)
	
	# Project cursor on target position
	grappleCursor.position = camera.unproject_position(targetPosition)
	
	# Show cursor if facing target position
	if perpDotProduct < 0:
		grappleCursor.show()
	else:
		grappleCursor.hide()
