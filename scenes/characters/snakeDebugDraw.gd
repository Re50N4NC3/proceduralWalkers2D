extends RigidBody2D

func _draw():
	draw_circle(position, 20, Color.BLACK)
	pass

func _process(delta):
	queue_redraw()
