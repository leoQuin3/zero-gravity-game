extends Node
class_name GenericController

# -------------------------------- Attributes --------------------------------
# A character to be controlled
@export var puppet: GenericCharacter

# ------------------------------- Class Methods -------------------------------
# Add character to controller
func assign_puppet(character: GenericCharacter) -> void:
	if !puppet:
		puppet = character
		puppet.connected_to_controller.emit()

# Remove character from controller
func remove_puppet() -> void:
	if puppet:
		puppet.disconnected_from_controller.emit()
		puppet = null

# --------------------- Puppet Method Callers (to define) ---------------------
# Call puppet's move() method
func control_move(delta: float) -> void:
	pass

# Call puppet's jump() method
func control_jump(delta: float) -> void:
	pass

# --------------------------------- Main Loop ---------------------------------
func _ready():
	if puppet:
		puppet.connected_to_controller.emit()

func _process(delta):
	if puppet:
		control_move(delta)
		control_jump(delta)
