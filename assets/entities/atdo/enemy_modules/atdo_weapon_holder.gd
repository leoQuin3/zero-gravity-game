extends Node3D

@export var bulletSpeed: float = 25

@export_category("Connect Node and Scene")
@export var bullet: PackedScene
@export var raycast: RayCast3D

# Fire projectile
func fire():
	# Instantiate bullet
	var newBullet: Bullet = bullet.instantiate()
	
	# Initialize
	newBullet.initialVelocity = -self.global_transform.basis.z * bulletSpeed
	newBullet.global_position = self.global_position
	
	# Add bullet as child to tree scene
	get_tree().root.add_child(newBullet)
