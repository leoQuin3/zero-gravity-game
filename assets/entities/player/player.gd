# Player properties and methods are defined here. They can be called by the State scripts.
extends CharacterBody3D
class_name Player

# Parameters
@export var MAX_SPEED: float = 7
@export var THRUST_SPEED: float = 100
@export var MOUSE_IS_CAPTURED: bool = true
@export var CAMERA_SENSITIVITY: float = 0.003

@export_category("Connect Nodes")
@export var cameraHead: Node3D
@export var weaponHolder: Node3D

# Inventory
var weaponInventory: Array
var ammoInventory: Dictionary

# Currently equipped weapon
var currentWeapon: Weapon
var currWeaponIndex: int = 0

# Update player physics.
func _physics_process(delta) -> void:
	move_and_slide()

# Control camera rotation using mouse input. Min and max pitch are in radians.
func fp_camera_look(event: InputEventMouseMotion, minPitch: float, maxPitch: float):
	var newPitch = event.relative.y
	var newYaw = event.relative.x
	
	#Update camera pitch and player yaw.
	cameraHead.rotation.x -= newPitch * CAMERA_SENSITIVITY
	self.rotation.y -= newYaw * CAMERA_SENSITIVITY
	
	# Cap camera pitch.
	cameraHead.rotation.x = clamp(cameraHead.rotation.x, minPitch, maxPitch)

# Move in all directions using input keys. Always facing in camera's direction.
func player_control_move(delta: float):
	# Calculate direction vector from keys and camera orientation
	var inputVector: Vector2 = Input.get_vector("left", "right", "forward", "back")
	var newDirection: = (cameraHead.global_transform.basis * Vector3(inputVector.x, 0 , inputVector.y)).normalized()
	
	# Accelerate player
	if inputVector:
		velocity += newDirection * THRUST_SPEED * delta
	
	# Enforce maximum velocity
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED

# Append weapon to inventory.
func add_weapon_to_inventory(weapon: Weapon):
	weaponInventory.append(weapon)
	
	# If player had no weapons, equip their first weapon
	if weaponInventory.size() == 1:
		equip_weapon_at_index(0)

##TODO: Implement ammunition system here and in ammo.gd.
func add_ammo_to_inventory(ammo):
	pass

# Use mouse wheel to scroll through inventory.
func scroll_weapon_index(event: InputEventMouseButton):
	# Get size of weapon array
	var arraySize = weaponInventory.size()
	
	# If array is empty or has only one weapon, return
	if arraySize < 2:
		return
	
	# Increment current index
	if event.button_index == MOUSE_BUTTON_WHEEL_UP:
		currWeaponIndex += 1
	elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		currWeaponIndex -= 1
	else:
		return
		
	# Keep index within array bounds
	if currWeaponIndex >= arraySize:
		currWeaponIndex = 0
	elif currWeaponIndex < 0:
		currWeaponIndex = arraySize - 1
	
	#Equip weapon at current index
	equip_weapon_at_index(currWeaponIndex)

# Equip weapon at given index.
#TODO: add safeguard if out of bounds
func equip_weapon_at_index(index: int):
	if currentWeapon:
		weaponHolder.remove_child(currentWeapon)
	currentWeapon = weaponInventory[index]
	weaponHolder.add_child(currentWeapon)

# Call fire method on current weapon.
func fire_weapon():
	if currentWeapon:
		currentWeapon.fire()
