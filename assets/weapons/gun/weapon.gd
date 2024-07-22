extends Node3D
class_name Weapon

@export var bullet: PackedScene
@export var animationPlayer: AnimationPlayer

@export_category("Bullet Settings")
@export var BULLET_SPEED: float = 25
@export var ammoAmount: int = 10

#TODO: Finish structuring weapon class, implementing rounds and ammo system

func _ready():
	animationPlayer.play("equip")

func fire():
	if ammoAmount > 0:
		ammoAmount -= 1
		spawn_bullet()
		animationPlayer.play("shoot")

func add_ammo(amount: int):
	ammoAmount += amount

func _on_child_entered_tree(node):
	animationPlayer.play("equip")

func spawn_bullet():
	var newBullet: Bullet = bullet.instantiate()
	newBullet.initialVelocity = -self.global_transform.basis.z * BULLET_SPEED
	newBullet.global_position = self.global_position
	get_tree().root.add_child(newBullet)
