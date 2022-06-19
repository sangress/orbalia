extends Node2D

var scene_changer = preload("res://scenes/SceneChanger.tscn")

onready var orb = $Orb
onready var flowerust = $Flowerust
onready var orba = $Orba
onready var orbs_collected_label = $CanvasLayer/orbs_collected
onready var reset_timer = $ResetTimer

signal hit_enemy
signal hit_flower

var orbs_collected = 0

func _ready():
	flowerust.target = orb	
	SceneChanger.destroy()
	orba.eat_mode()


func _on_CheckBox_toggled(button_pressed):
	if button_pressed:
		orb.set_wheel_dir("up")
	else:
		orb.set_wheel_dir("down")	


func _on_Game_hit_enemy(val):
	pass
#	print("ADD_SCORE ", val)


func _on_eat_area_body_entered(body):
	if body.is_in_group("green_orbs"):
		body.queue_free()
		orbs_collected += 1
		orbs_collected_label.text = String(orbs_collected)
		orba.eat()
		if orbs_collected >= 9:
			load_end()

func load_end():
#	var instance = scene_changer.instance()
#	add_child(instance)
	SceneChanger.change_scene("res://scenes/End.tscn")

func reset_level():
	SceneChanger.change_scene("res://scenes/Game.tscn")
	
func _on_Game_hit_flower():	
	if flowerust.hp <= 0:
		reset_timer.start()


func _on_ResetTimer_timeout():
	reset_level()
