# An area node that gives weapon to player if overlapping

extends Area3D
class_name Pickup

#TODO: create area node that gives player a weapon. extend to items later
@export var sprite: CompressedTexture2D
@export var weapon: PackedScene
@export var ammoAmount: int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	if sprite:
		$Sprite3D.texture = sprite

# Give weapon to player
func _on_body_entered(body):
	if weapon and weapon.can_instantiate() and body is Player:
		var newWeapon: Weapon = weapon.instantiate()
		newWeapon.shooter = body
		newWeapon.ammoAmount = ammoAmount
		
		body.player_weapon_to_inventory(newWeapon)
		
		self.queue_free()
