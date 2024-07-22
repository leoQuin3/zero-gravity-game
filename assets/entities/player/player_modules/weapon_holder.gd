extends Node3D

var weaponInventory: Array

# Currently equipped weapon
var currentWeapon: Weapon
var currWeaponIndex: int = 0

# Add pre-existing weapons in WeaponHolder to inventory.
func _ready():
	for weapon in get_children():
		if weapon is Weapon:
			add_weapon_to_inventory(weapon)
			
# Append weapon to inventory.
func add_weapon_to_inventory(weapon: Weapon):
	weaponInventory.append(weapon)
	
	# If player had no weapons, equip their first weapon
	if weaponInventory.size() == 1:
		equip_weapon_at_index(0)

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
		# If event is neither wheep up or wheel down, ignore and terminate.
		return
		
	# Keep index within array bounds
	if currWeaponIndex >= arraySize:
		currWeaponIndex = 0
	elif currWeaponIndex < 0:
		currWeaponIndex = arraySize - 1
	
	# Equip weapon at current index
	equip_weapon_at_index(currWeaponIndex)

# Equip weapon at given index.
func equip_weapon_at_index(index: int):
	# Remove previously equipped weapon from WeaponHolder.
	if currentWeapon:
		self.remove_child(currentWeapon)
		
	# Get weapon from array and add to WeaponHolder
	currentWeapon = weaponInventory[index]
	self.add_child(currentWeapon)

# Call fire method of current weapon.
func fire_weapon(event: InputEventMouseButton):
	if currentWeapon and event.button_index == MOUSE_BUTTON_LEFT:
		currentWeapon.fire()
