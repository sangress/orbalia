extends RigidBody2D

var target

func _physics_process(delta):
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("orb"):
		body.emit_signal("collect_orb")
