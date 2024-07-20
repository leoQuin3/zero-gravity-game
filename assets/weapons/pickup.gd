# A general purpose area used to represent items which can be picked up by Player.
extends Area3D
class_name Pickup

@export var itemScene: PackedScene
@export var itemSprite: CompressedTexture2D
@onready var SPRITE: = get_node("PickupSprite3D")
var item = null

func _ready():
	if itemScene != null:
		item = itemScene.instantiate()
	if itemSprite:
		SPRITE.texture = itemSprite

func _on_body_entered(body):
	if body is Player and item is Weapon:
		print("giving weapon")
		body.add_weapon_to_inventory(item)
		queue_free()
