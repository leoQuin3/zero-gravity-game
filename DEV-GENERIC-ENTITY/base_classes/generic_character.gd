extends CharacterBody3D
class_name GenericCharacter

# ------------ Attributes ------------
# Useful variables for basic movement.
var speed: float
var jump_velocity: float
var look_direction: Vector3

# --------------------------------- Methods ---------------------------------
# Methods are implemented by inheriters of this class. They are called BY the
# Character Controller. If a character is not assigned to a controller, it
# would simply do nothing.

# Move around
func move() -> void:
	pass

# "Look" at a point
func look() -> void:
	pass

# Jump
func jump() -> void:
	pass

# Do something upon death (e.g. play animation)
func die() -> void:
	pass
