# Module that accounts for health
extends Node3D

signal damage_taken(amount: int)
signal health_ran_out

@export var host: CollisionObject3D

#BUG: Bullet sometimes isnt deleted when health reaches zero

# Health amount
@export var health: int = 100:
	set(amount):
		health = amount
		# Cap health at zero and emit signal
		if health <= 0:
			health = 0
			emit_signal("health_ran_out")

# Detect Bullets
func _on_hitbox_area_entered(area):
	if area is Bullet:
		# If detecting host, ignore and terminate
		if area.shooter == host:
			return
		
		# Get bullet damage
		var bulletDamage: int = area.damage
		
		# Emit signal
		emit_signal("damage_taken", bulletDamage)
		
		# Decrease health
		health -= bulletDamage
