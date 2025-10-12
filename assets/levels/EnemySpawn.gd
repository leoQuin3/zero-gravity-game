extends Node3D

@export var enemyScene: PackedScene

func _on_pickup_body_entered(body):
	if !enemyScene or !enemyScene.can_instantiate():
		print("ERROR::Cant spawn enemies")
		return
	
	randomize()
	
	for i in range(3):
		var randomPosition: Vector3 = self.global_position + Vector3(randi_range(-10, 10), randi_range(-5, 5), randi_range(-5, 5))
		var newEnemy = enemyScene.instantiate()
		
		newEnemy.position = randomPosition
		
		$"..".add_child(newEnemy)
