# This node is the grappling hook, allowing the player to move toward a position.
# The action assigned is "grapple" (Q) in the GRAPPLING state script.

extends Node3D
class_name GrapplingHook

@export var grappleSpeed: float = 15
@export var strafeSpeed: float = 15
@export var cancelDistance: float = 2

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
	# Set velocity towards targetPosition
	var targetDirection: Vector3 = (targetPosition - player.position).normalized()
	player.velocity = targetDirection * grappleSpeed
	
	# Update cursor
	update_cursor_position(targetPosition)
	
# Allow player to strafe left and right
#BUG: If grapple() isnt being called, player will dramatically accelerate
func player_grapple_strafe(player:Player, targetPosition: Vector3):
	# Point grapple holder to target position
	self.look_at(targetPosition, Vector3.UP)
	
	# Get input and grapple holder's basis
	var inputAxis: int = Input.get_axis("left", "right")
	var directionVector: Vector3 = (self.global_transform.basis * Vector3(inputAxis, 0, 0)).normalized()
	
	# Update player velocity
	if inputAxis:
		player.velocity += (directionVector * strafeSpeed)

# Show cursor where player is moving towards
#FIXME: When player looks away from target position, the cursor still appears.
func update_cursor_position(targetPosition: Vector3):
	grappleCursor.position = camera.unproject_position(targetPosition)
