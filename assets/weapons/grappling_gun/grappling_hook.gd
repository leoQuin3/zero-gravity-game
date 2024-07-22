extends Node3D
class_name GrapplingHook

@export var parent: Player
@export var raycast: RayCast3D

func fire():
	print(raycast.get_collision_point())
	#TODO: move player towards collision point.
