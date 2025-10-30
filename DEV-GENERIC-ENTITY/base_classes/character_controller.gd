extends Node
class_name CharacterController

# ---------------- Attributes ----------------
# A character to be controlled
@export var character_puppet: GenericCharacter

# ---------------------------------- Methods ----------------------------------
# Methods are implemented by inheriters of this class. These methods call their
# puppet's corresponding methods. For instance, when a user presses a key, the 
# controller can call jump() upon that key event.

# Call puppet's move() method
func control_move() -> void:
	pass

# Call puppet's look() method
func control_look() -> void:
	pass

# Call puppet's look() method
func control_jump() -> void:
	pass

# All logic for controlling characters are written here, in _process() or
# _physics_process(). But such implementations are done by inheriters of this
# class (i.e. Player Controller where inputs call functions, or an AI 
# controller where characters are automated NPCS).
func _process(delta):
	pass
