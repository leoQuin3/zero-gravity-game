extends Node3D
class_name GrapplingHook

@export var raycast: RayCast3D
@export var grappleCursor: Sprite2D
@export var camera: Camera3D
@export var grappleSpeed: float = 15
@export var strafeSpeed: float = 15
@export var cancelDistance: float = 2

# Get position to move towards
func get_grapple_point() -> Vector3:
	return raycast.get_collision_point()

# Determine whether raycast is touching anything
func can_grapple() -> bool:
	return raycast.is_colliding()

# Move player towards grappling position
func grapple(player: Player, targetPosition: Vector3) -> void:
	# Set velocity towards targetPosition
	var targetDirection: Vector3 = (targetPosition - player.position).normalized()
	player.velocity = targetDirection * grappleSpeed
	
# Allow player to strafe left and right
func player_grapple_strafe(player:Player, targetPosition: Vector3):
	# Point grapple holder to target position
	self.look_at(targetPosition, Vector3.UP)
	
	# Get input and grapple holder's basis
	var inputAxis: int = Input.get_axis("left", "right")
	var directionVector: Vector3 = (self.global_transform.basis * Vector3(inputAxis, 0, 0)).normalized()
	
	# Update player velocity
	#FIXME: If grapple() isnt being called, player will dramatically accelerate
	if inputAxis:
		player.velocity += (directionVector * strafeSpeed)

func update_cursor_position(targetPosition: Vector3):
	grappleCursor.position = camera.unproject_position(targetPosition)
