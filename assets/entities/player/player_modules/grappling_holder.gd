extends Node3D
class_name GrapplingHook

@export var raycast: RayCast3D
@export var grappleSpeed: float = 10

#TODO:
#	1) Define methods for state machine to use
#	3) Once in state GRAPPLING, call these methods

# Get position to move towards
func get_grapple_point() -> Vector3:
	if raycast.is_colliding():
		return raycast.get_collision_point()
	else:
		return Vector3.ZERO

# Move player towards grappling position
func grapple(player: Player, newPosition) -> void:
	var newVelocity: Vector3 = (newPosition - player.position) * grappleSpeed
	player.velocity = newVelocity
	print("grappling toward " + newPosition + " at speed " + newVelocity.length())
