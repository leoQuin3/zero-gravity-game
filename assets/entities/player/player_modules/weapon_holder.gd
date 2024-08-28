# This module will hold collected weapons, and allow the player to equip them.
extends Node3D

# Node to hold weapon
@export var weaponHolder: Node3D

# Store weapons
var weaponInventory: Array

# Currently equipped weapon
var currentWeapon: Weapon
var currWeaponIndex: int = 0

# Properties of array
var inventorySize: int = 0

# Add pre-existing weapons in WeaponHolder to inventory.
func _ready():
	for weapon in get_children():
		if weapon is Weapon:
			add_weapon(weapon)
			remove_child(weapon)
	
	# Equip first weapon
	if !weaponInventory.is_empty():
		currentWeapon = weaponInventory[0]
		equip_weapon_at_index(0)

# Append weapon to inventory.
func add_weapon(weapon: Weapon):
	weaponInventory.append(weapon)
	inventorySize += 1

# Use mouse wheel to scroll through inventory.
func scroll_weapon_select(event: InputEventMouseButton):
	# If array is empty or has only one weapon, return
	if inventorySize <= 1:
		return
	
	# Increment current index
	if event.button_index == MOUSE_BUTTON_WHEEL_UP:
		currWeaponIndex += 1
	elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		currWeaponIndex -= 1
	else:
		# If event is neither wheep up or wheel down, ignore and terminate.
		return
		
	# Keep index within array bounds
	if currWeaponIndex >= inventorySize:
		currWeaponIndex = 0
	elif currWeaponIndex < 0:
		currWeaponIndex = inventorySize - 1
	
	# Equip weapon at current index
	equip_weapon_at_index(currWeaponIndex)

# Equip weapon at given index.
func equip_weapon_at_index(index: int):
	# Remove existing weapon from holder, and add new weapon
	weaponHolder.remove_child(currentWeapon)
	currentWeapon = weaponInventory[index]
	weaponHolder.add_child(currentWeapon)

# Call fire method of current weapon.
func fire_weapon(event: InputEventMouseButton):
	if currentWeapon and event.button_index == MOUSE_BUTTON_LEFT:
		currentWeapon.fire()
