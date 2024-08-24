# Module that accounts for health. Use signals (eg. from Area3D) to manipulate health.
extends Node3D
class_name HealthModule

signal health_decreased(amount: int)
signal health_increased(amount:int)
signal health_ran_out
signal health_maxed_out

# Health amount
@export var maxHealth: int = 100
@export var health: int = 100:
	set(amount):
		health = amount
		
		# Cap health at zero
		if health <= 0:
			health = 0
			emit_signal("health_ran_out")
			
		# Cap health at max
		elif health >= maxHealth:
			health = maxHealth
			emit_signal("health_maxed_out")

# Reduce health
func take_damage(amount: int) -> void:
	self.health -= amount
	emit_signal("health_decreased", amount)

# Increase health
func heal(amount: int) -> void:
	self.health += amount
	emit_signal("health_increased", amount)
