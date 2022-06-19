extends Node2D

onready var anim = $AnimationPlayer
onready var voice = $voice
onready var speak = $SPEAK
onready var eat = $EAT
onready var eat_sfx = $eat_sfx

var is_speaking = false
enum MODES {
	SPEAK,
	EAT
}
var mode = MODES.SPEAK

func speak():
	is_speaking = true
	voice.play()
	anim.play("speak")

func dont_speak():
	is_speaking = false
	voice.stop()
	anim.play("RESET")

func eat_mode():
	speak.visible = false
	eat.visible = true
	mode = MODES.EAT

func eat():
	eat_sfx.play()
	anim.play("eat")

