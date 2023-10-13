extends RigidBody2D

@export var target : Node  # The target RigidBody2D to follow
var desired_distance = 20  # The desired rigid distance from the target

func _process(_delta):
	if target:
		var direction = target.global_position - global_position
		var distance = direction.length()
		look_at(target.position)

		if distance != 0:
			var new_position = target.global_position - direction.normalized() * desired_distance
			global_position = new_position
