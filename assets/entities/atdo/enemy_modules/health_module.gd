# Module that accounts for health
extends Node3D

signal damage_taken(amount: int)
signal health_ran_out

@export var parent: CollisionObject3D

# Health amount
@export var health: int = 100:
	set(amount):
		health = amount
		
		# Cap health at zero and emit signal
		if health <= 0:
			health = 0
			emit_signal("health_ran_out")

# Change health
func _on_hitbox_area_entered(area):
	if area is Bullet:
		if area.shooterCollisionLayer == parent.get_collision_layer():
			return
		var bulletDamage: int = area.damage
		health -= bulletDamage
		emit_signal("damage_taken", bulletDamage)
