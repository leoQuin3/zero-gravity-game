extends Node3D
class_name Weapon

@export var bullet: PackedScene
@export var animationSprite: AnimatedSprite2D

#TODO: Fix pick up and firing before working on bullets

#func _ready():
	#animationSprite.play("idle")

func fire():
	animationSprite.play("shoot")
