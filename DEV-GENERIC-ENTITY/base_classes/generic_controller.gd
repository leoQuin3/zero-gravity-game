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

# --------------------------- Puppet Method Callers ---------------------------
# Call puppet's move() method
func control_move(delta) -> void:
	if puppet:
		var input_dir = Input.get_vector("left", "right", "forward", "back")
		var move_dir = Vector3(input_dir.x, 0, input_dir.y)
		puppet.move(move_dir, delta)

# Call puppet's look() method
func control_jump(delta) -> void:
	if puppet and Input.is_action_just_pressed("jump"):
		puppet.jump(delta)

# --------------------------------- Main Loop ---------------------------------
func _ready():
	if puppet:
		puppet.connected_to_controller.emit()

func _process(delta):
	control_move(delta)
	control_jump(delta)

# ----------------------------- Reciever Methods -----------------------------
