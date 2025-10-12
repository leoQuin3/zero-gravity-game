extends CharacterBody3D
class_name Player

# Parameters
const MAX_SPEED: float = 10
const THRUST_SPEED: float = 100

# FIXME: go back to drawing board on composition (ie. all of this...)
@export_category("Connect Nodes")
@export var cameraHolder: CameraHolder
@export var weaponInventory: WeaponInventory

# Update player physics.
func _physics_process(delta) -> void:
	move_and_slide()

# Player movement
#FIXME: may need to handle case if cameraHolder doesn't exist
func player_control_move(delta: float):
	var inputVector: Vector2 = Input.get_vector("left", "right", "forward", "back")
	var newDirection: = (cameraHolder.global_transform.basis * Vector3(inputVector.x, 0 , inputVector.y)).normalized()
	
	if inputVector:
		velocity += newDirection * THRUST_SPEED * delta
	else:
		velocity = lerp(velocity, Vector3.ZERO, 0.05)
	
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED

# Wrapper to adding weapon to inventory
func player_weapon_to_inventory(weapon: Weapon):
	print("adding to inventory")
	weaponInventory.add_weapon(weapon)
	weaponInventory.equip_weapon_at_index(0)
