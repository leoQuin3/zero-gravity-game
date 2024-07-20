# A general purpose area node that can be used to represent weapons, ammo, etc.
extends Area3D
class_name Pickup

@export var ITEM_SCENE: PackedScene
var item = null

func _ready():
	if ITEM_SCENE != null and ITEM_SCENE.can_instantiate():
		item = ITEM_SCENE.instantiate()
