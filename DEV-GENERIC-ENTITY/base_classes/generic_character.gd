extends CharacterBody3D
class_name GenericCharacter

# -------------------------------- Attributes ---------------------------------
var speed: float = 200
var jump_velocity: float = 200
var is_controlled: bool = false

# ---------------------------------- Methods ----------------------------------
#FIXME: Player drifts when disconnected from controller
func move(direction: Vector3, delta) -> void:
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * speed * delta, 0.5)
		velocity.z = move_toward(velocity.z, direction.z * speed * delta, 0.5)
	else:
		velocity.x = move_toward(velocity.x, 0, 0.5)
		velocity.z = move_toward(velocity.z, 0, 0.5)
	
func jump(delta) -> void:
	if is_on_floor():
		velocity.y = jump_velocity * delta

# Do something upon death (e.g. play animation)
func die() -> void:
	pass

func _process(delta):
	if !is_on_floor():
		velocity.y -= 9.8 * delta
	
	move_and_slide()
