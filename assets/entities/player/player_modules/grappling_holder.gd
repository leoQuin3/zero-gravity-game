extends Node3D
class_name GrapplingHook

@export var raycast: RayCast3D
@export var grappleSpeed: float = 10

#TODO:
#	1) Define methods for state machine to use
#	3) Once in state GRAPPLING, call these methods

# Get position to move towards
func get_grapple_point() -> Vector3:
	return raycast.get_collision_point()

# Determine whether raycast is touching anything
func can_grapple() -> bool:
	return raycast.is_colliding()

# Move player towards grappling position
func grapple(player: Player) -> void:
	var targetPosition: Vector3 = get_grapple_point()
	var newVelocity: Vector3 = (targetPosition - player.position).normalized() * grappleSpeed
	
	player.velocity = newVelocity
