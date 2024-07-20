extends Node3D
class_name Weapon

@export var bullet: PackedScene
@export var animationSprite: AnimatedSprite2D

func _ready():
	animationSprite.play("idle")

func fire():
	animationSprite.play("shoot")
