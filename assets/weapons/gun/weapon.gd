extends Node3D
class_name Weapon

@export var bulletSpeed: float = 50
@export var bulletDamage: int = 25
@export var ammoAmount: int = 10

@export_category("Connect Node and Scene")
@export var bullet: PackedScene
@export var animationPlayer: AnimationPlayer
@export var shooter: CollisionObject3D

#TODO: Generalize weapon system (Use ATDO's example), and extend to player's gun
#BUG: Sprite gets stuck midframe, or doesn't move at all, when player immediately shoots during equip animation.
#BUG: Bullet sometimes isnt deleted when health reaches zero

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
	# Instantiate
	var newBullet: Bullet = bullet.instantiate()
	
	# Initialize 
	newBullet.damage = bulletDamage
	newBullet.initialVelocity = -self.global_transform.basis.z * bulletSpeed
	newBullet.global_position = self.global_position
	
	# Exclude shooter from collision mask
	newBullet.shooter = shooter
	
	get_tree().root.add_child(newBullet)
