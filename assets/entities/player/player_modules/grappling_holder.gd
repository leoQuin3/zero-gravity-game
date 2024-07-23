extends Node3D
class_name GrapplingHook

@export var raycast: RayCast3D
@export var grappleSpeed: float = 30

# Get position to move towards
func get_grapple_point() -> Vector3:
	return raycast.get_collision_point()

# Determine whether raycast is touching anything
func can_grapple() -> bool:
	return raycast.is_colliding()

# Move player towards grappling position
func grapple(player: Player) -> void:
	var targetPosition: Vector3 = get_grapple_point()
	var targetDirection: Vector3 = (targetPosition - player.position).normalized()
	
	player.velocity = targetDirection * grappleSpeed

# Allow player to strafe left and right while grappling
func player_grapple_move(player:Player, event: Input):
	pass
