extends Node2D

@export var target : Node2D  # The target object to follow
var follow_distance : float = 50  # Distance at which the node starts following the target
var lerp_speed : float = 2.1  # Speed at which the node moves towards the target
var moving: bool = false
var target_position: Vector2

func _ready():
	target_position = target.position

func _process(delta):
	if target:
		var distance_to_target = global_position.distance_to(target.global_position)

		print(str(distance_to_target) + "|"+str(position) + "|" + str(target_position))
		if distance_to_target > follow_distance and moving == false:
			moving = true
			target_position = target.global_position
			print(target_position)
			
		global_position = lerp(position, target_position, lerp_speed * delta)
		
		if distance_to_target < 20:
			moving = false
			
