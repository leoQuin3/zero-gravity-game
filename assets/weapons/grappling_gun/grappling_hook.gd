extends Node3D
class_name GrapplingHook

@export var player: Player
@export var raycast: RayCast3D

#TODO:
#	1) Write grapple methods and write signal
#	2) Use signal to switch player state

func grapple():
	var collisionPoint: Vector3 = raycast.get_collision_point()
	player.velocity = (collisionPoint - player.position)
	print(collisionPoint)

#TODO: Let state function handle input
func _process(delta):
	if raycast.is_colliding() and Input.is_action_just_pressed("grapple"):
		grapple()
