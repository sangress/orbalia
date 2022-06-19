extends Sprite


func _process(delta):
	scale.x = lerp(scale.x, 1, 0.05)
	scale.y = lerp(scale.y, 1, 0.05)
	
