extends CanvasLayer


func _ready():
	pass


func _on_Timer_timeout():
	SceneChanger.change_scene("res://scenes/Game.tscn")


func _on_Button_pressed():
	SceneChanger.change_scene("res://scenes/Game.tscn")
