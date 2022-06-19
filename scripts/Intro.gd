extends Node2D

export var is_end = false

onready var orba = $Orba
onready var anim = $AnimationPlayer
onready var orba_text = $CanvasLayer/OrbaText
onready var buttons = $CanvasLayer/ButtonsControl

var timer = Timer.new()
var text_index = 0


var texts = [
	"can you help me?", 
	"I am very sick", 
	"my only chance", 
	"is green orbs", 
	"if you agree", 
	"I will meet you at the ring",
	"I need 9 green orbs to heal myself",
	"just shoot the white orbs",
	"from the Voluptuous flower",
	"it will spawn green orbs if you shoot it",
	"get the orbs to me mouth",	
	"but be careful",
	"don't let the white orbs hit you",
	"and don't shoot the flower."]

var texts_end = [
	"Thank you!",
	"you saved me life!",
	"happy, I am happy now."
]

func _ready():
	if is_end:
		texts = texts_end
	orba_text.text = texts[text_index]
	timer.wait_time = 2
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	timer.start()

func _input(event):
	if not buttons.visible and Input.is_action_just_pressed("left"):
		skip()

func on_timer_timeout():
	if orba.is_speaking:		
#		anim.play("RESET")	
		orba.dont_speak()
		if text_index > texts.size() - 1:
			timer.stop()
			buttons.visible = true
	else:
		if text_index <= texts.size() - 1:
			orba_text.text = texts[text_index]
		anim.play("RESET")		
		anim.play("typewriter")		
		orba.speak()
		text_index += 1		

func skip():
	on_timer_timeout()

func _on_AgreeButton_pressed():
	SceneChanger.change_scene("res://scenes/ControlsGuide.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
