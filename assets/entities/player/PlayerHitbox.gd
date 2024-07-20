# Handles hit detection from weapons, bullets, etc.
extends Area3D

signal weapon_picked_up(weapon: Weapon)

func _on_area_entered(area):
	if area is Pickup:
		emit_signal("weapon_picked_up", area.item)
