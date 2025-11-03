extends Node
class_name GenericController

# Signals
signal control_moved(direction: Vector3)
signal control_looked(direction: Vector3)
signal control_jumped()

# -------------------------------- Attributes --------------------------------
# A character to be controlled
@export var puppet: GenericCharacter

# ------------------------------- Class Methods -------------------------------
# Make character puppet
func assign_puppet(character: GenericCharacter) -> void:
	puppet = character
	connect_puppet()

# Disconnect character as puppet
func remove_puppet() -> void:
	puppet = null
	disconnect_puppet()

# Connect controller signals to puppet's methods
func connect_puppet():
	control_moved.connect(Callable(puppet, "move"))
	control_looked.connect(Callable(puppet, "look"))
	control_jumped.connect(Callable(puppet, "jump"))

# Disconnect controller signals to puppet's methods
func disconnect_puppet():
	control_moved.disconnect(Callable(puppet, "move"))
	control_looked.disconnect(Callable(puppet, "look"))
	control_jumped.disconnect(Callable(puppet, "jump"))

# --------------------------- Puppet Method Callers ---------------------------
# Call puppet's move() method
func control_move(delta) -> void:
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var move_dir = Vector3(input_dir.x, 0, input_dir.y)
	emit_signal("control_moved", move_dir, delta)

# Call puppet's look() method
func control_jump(delta) -> void:
	if Input.is_action_just_pressed("jump"):
		emit_signal("control_jumped", delta)

# ----------------------------- Reciever Methods -----------------------------
#TEMP: testing what happens when puppet is disconnected
func _on_timer_timeout():
	print("Disconnecting player!!!")
	disconnect_puppet()

# --------------------------------- Main Loop ---------------------------------
func _ready():
	if puppet:
		connect_puppet()

func _process(delta):
	control_move(delta)
	control_jump(delta)
