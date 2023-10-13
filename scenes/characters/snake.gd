extends CharacterBody2D

@export var speed: float = 250
var mouse_position = null
var stop_distance: float = 40  # Minimum distance to stop movement

var snake_body_part_scene: PackedScene = preload("res://scenes/characters/snake_body_part.tscn")
var num_body_parts: int = 15  # Number of body parts to spawn

var snake_leg_target_scene: PackedScene = preload("res://scenes/characters/snake_leg_target.tscn")
var leg_body_parts: Array[int] = [3, 6]

func _ready():
	spawn_body_parts()
	
func spawn_body_parts():
	var target_node = self  # Start with the head as the initial target
	
	for i in range(num_body_parts):
		var body_part_instance = snake_body_part_scene.instantiate()
		
		body_part_instance.target = target_node  # Assign the target to the body part
		get_parent().add_child.call_deferred(body_part_instance)
		
		target_node = body_part_instance
		
		if i in leg_body_parts:
			spawn_legs(body_part_instance)
			
func spawn_legs(parent_body_part):
	for dir in [-1,1]:
		var legs_target_instance = snake_leg_target_scene.instantiate()
		parent_body_part.add_child.call_deferred(legs_target_instance)
		legs_target_instance.position += Vector2(40, -30 * dir)
	

func _physics_process(delta):
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position).normalized()
	var distance_to_mouse = (mouse_position - position).length()

	if distance_to_mouse > stop_distance:
		velocity = lerp(velocity, direction * speed, delta * 4)
	else:
		velocity = lerp(velocity, Vector2(0,0), delta * 7)

	move_and_slide()
	rotation = velocity.angle()
