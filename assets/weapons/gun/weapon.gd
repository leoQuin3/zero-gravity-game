extends Node3D
class_name Weapon

@export var bullet: PackedScene
@export var animationPlayer: AnimationPlayer
@export var bulletSpeed: float = 25

func _ready():
	animationPlayer.play("equip")

func fire():
	var newBullet: Bullet = bullet.instantiate()
	newBullet.initialVelocity = -self.global_transform.basis.z * bulletSpeed
	newBullet.global_position = self.global_position
	get_tree().root.add_child(newBullet)
	animationPlayer.play("shoot")

func _on_child_entered_tree(node):
	animationPlayer.play("equip")
