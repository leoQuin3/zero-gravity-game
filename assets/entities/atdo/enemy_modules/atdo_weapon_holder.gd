extends Node3D

@export var bullet: PackedScene
@export var BULLET_SPEED: float = 25

#TODO: Finish structuring weapon class, implementing rounds and ammo system

func fire():
	spawn_bullet()
	#FIXME: Add animations

func spawn_bullet():
	var newBullet: Bullet = bullet.instantiate()
	newBullet.initialVelocity = -self.global_transform.basis.z * BULLET_SPEED
	newBullet.global_position = self.global_position
	get_tree().root.add_child(newBullet)
