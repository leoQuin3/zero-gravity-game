extends CharacterBody3D
class_name GenericCharacter

# ---------------------------------- Signals ----------------------------------
signal connected_to_controller
signal disconnected_from_controller

# -------------------------------- Attributes ---------------------------------
var move_friction: float = 0.35
var speed: float = 200
var jump_velocity: float = 300
var is_controlled: bool = false

# ---------------------------------- Methods ----------------------------------
func move(direction: Vector3, delta) -> void:
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * speed * delta, move_friction)
		velocity.z = move_toward(velocity.z, direction.z * speed * delta, move_friction)
	elif direction == Vector3.ZERO:
		velocity.x = move_toward(velocity.x, 0, move_friction)
		velocity.z = move_toward(velocity.z, 0, move_friction)
	
func jump(delta) -> void:
	if is_on_floor():
		velocity.y = jump_velocity * delta

# Do something upon death (e.g. play animation)
func die() -> void:
	pass

# ----------------------------- Reciever Methods -----------------------------
func _on_connected_to_controller():
	print("controlling")
	is_controlled = true

func _on_disconnected_from_controller():
	print("disconnecting")
	is_controlled = false
	
# --------------------------------- Main Loop ---------------------------------
# Connect internal receiver methods before controller is ready
func _enter_tree():
	connected_to_controller.connect(Callable(self, "_on_connected_to_controller"))
	disconnected_from_controller.connect(Callable(self, "_on_disconnected_from_controller"))

func _physics_process(delta):
	if !is_on_floor():
		velocity.y -= 9.8 * delta
	
	# Remain idle if not controlled
	print(is_controlled)
	if !is_controlled:
		move(Vector3.ZERO, delta)
	
	move_and_slide()
