extends Node3D
class_name Weapon

@export var bulletSpeed: float = 50
@export var bulletDamage: int = 25
@export var ammoAmount: int = 10

@export_category("Connect Node and Scene")
@export var bullet: PackedScene
@export var animationPlayer: AnimationPlayer

#TODO: Finish structuring weapon class, implementing rounds and ammo system
#BUG: Sprite gets stuck midframe, or doesn't move at all, when player immediately shoots during equip animation.

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
	newBullet.initialVelocity = -self.global_transform.basis.z * bulletSpeed
	newBullet.global_position = self.global_position
	newBullet.damage = bulletDamage
	get_tree().root.add_child(newBullet)
