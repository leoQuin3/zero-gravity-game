extends Node3D
class_name Weapon

@export var bullet: PackedScene
@export var animationPlayer: AnimationPlayer


func _ready():
	animationPlayer.play("equip")

func fire():
	print("BAM!")
	animationPlayer.play("shoot")

func _on_child_entered_tree(node):
	animationPlayer.play("equip")
