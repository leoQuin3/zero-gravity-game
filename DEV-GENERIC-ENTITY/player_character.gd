extends GenericCharacter
#class_name Player

func _ready():
	speed = 400.0
	move_friction = 0.25
	jump_velocity = 500

# ---------------------------- Methods (TO DEFINE) ----------------------------
# Physical actions that the player does.
 
# Move towards a direction
func move(direction: Vector3, delta) -> void:
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed * delta, move_friction)
		velocity.z = lerp(velocity.z, direction.z * speed * delta, move_friction)
	elif direction == Vector3.ZERO:
		velocity.x = lerp(velocity.x, 0.0, move_friction)
		velocity.z = lerp(velocity.z, 0.0, move_friction)

# Jump
func jump(delta) -> void:
	if is_on_floor():
		velocity.y = jump_velocity * delta

func get_gravity() -> float:
	print(velocity.y)
	if velocity.y < 0:
		return 9.8 * 2
	else:
		return 9.8
	
# Physics loop
func _physics_process(delta):
	if !is_on_floor():
		velocity.y -= get_gravity() * delta
	
	# Remain idle if not controlled
	if !is_controlled:
		move(Vector3.ZERO, delta)
	
	move_and_slide()
