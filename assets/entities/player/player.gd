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

var weaponInventory: Array
var currentWeapon: Weapon
var currWeaponIndex: int = 0

# Update player physics.
func _physics_process(delta) -> void:
	move_and_slide()

# Control camera rotation using mouse input. Pitch and yaw are passed in radians.
func fp_camera_look(event: InputEvent, minPitch: float, maxPitch: float):
	if event is InputEventMouseMotion:
		var newPitch = event.relative.y
		var newYaw = event.relative.x
		
		#Update camera pitch and player yaw
		cameraHead.rotation.x -= newPitch * CAMERA_SENSITIVITY
		self.rotation.y -= newYaw * CAMERA_SENSITIVITY
		
		# Cap camera pitch
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

####################
# *** TODO: Figure how to pick up weapon, select weapon, and fire weapon. ***
####################

func add_weapon_to_inventory(weapon: Weapon):
	weaponInventory.append(weapon)
	equip_weapon(weapon)
	print(weaponInventory)
	print(currentWeapon)
	print(currWeaponIndex)

#TODO: Fix issue where unable to switch weapons while able to shoot
#NOTE: (Maybe try unhandled input over input? May have to add unhandled input method in FSM)
func scroll_weapon_index(event: InputEvent):
	if weaponInventory.is_empty():
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			currWeaponIndex += 1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			currWeaponIndex -= 1
		elif event.button_index == MOUSE_BUTTON_MASK_LEFT:
			print("fire in the hole")
			return
		
		var inventorySize: int = weaponInventory.size()
		if currWeaponIndex >= inventorySize:
			currWeaponIndex = 0
		elif currWeaponIndex < 0:
			currWeaponIndex = inventorySize - 1
		
		var nextWeapon: Weapon = weaponInventory[currWeaponIndex]
		equip_weapon(nextWeapon)

# TODO: this may cause bugs. Reimplement this.
func equip_weapon(weapon: Weapon):
	weaponHolder.remove_child(currentWeapon)
	currentWeapon = weapon
	currWeaponIndex = weaponInventory.find(currentWeapon)
	weaponHolder.add_child(currentWeapon)

func fire_weapon():
	if currentWeapon:
		currentWeapon.fire()
