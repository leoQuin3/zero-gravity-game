extends Node3D

signal shots_fired

@export var bullet: PackedScene
@export var bulletSpeed: float = 25

@export_category("Connect Node and Scene")
@export var shooter: CollisionObject3D
@export var shooterHitbox: HealthModule

# Fire projectile
func fire():
	# Instantiate bullet
	var newBullet: Bullet = bullet.instantiate()
	
	# Initialize
	newBullet.initialVelocity = -self.global_transform.basis.z * bulletSpeed
	newBullet.global_position = self.global_position
	
	# Add bullet as child to tree scene
	get_tree().root.add_child(newBullet)
	
	# Exclude shooter and their hitbox from detection
	newBullet.shooter = shooter
	
	# Emit signal
	emit_signal("shots_fired")
