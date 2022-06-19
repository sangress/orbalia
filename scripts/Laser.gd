extends Area2D

export var is_scaled = false
export var ignore_group = "orb"
export var speed = 75
export var dmg = 10
export var value = 8
export (PackedScene) var SpawnOnDeath
export var num_spawn_death = 2

onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D


var scale_speed = 0.01
var is_init = true


func _ready():
	$Timer.start()

func _process(delta):
	# :HACK
	if is_init:
		is_init = false
		scale.x = 0.15
		scale.y = 0.15
	scale.x = lerp(scale.x, 1, 0.05)
	scale.y = lerp(scale.y, 1, 0.05)

func _physics_process(delta):
	position += transform.x * speed * delta	
#	if is_scaled:
#		scale.x += scale.x * speed * delta
#		scale.y += scale.y * scale_speed * delta

func _on_Laser_body_entered(body):
	if not is_in_group("orbullets") and body.is_in_group("boss"):
		body.emit_signal("on_hit", dmg)
	if body.is_in_group(ignore_group):
		return
#	if body.is_in_group("enemies"):
#		body.queue_free()
	body.emit_signal("on_hit", dmg)
	queue_free()


func _on_Timer_timeout():
	queue_free()

func set_ignore_group(groupName):
	ignore_group = groupName

func die():
	if SpawnOnDeath == null:
		queue_free()
	for n in num_spawn_death:
		var spawn = SpawnOnDeath.instance()
		spawn.position = position
		var parent = get_parent()
		spawn.target = parent.orb
		parent.add_child(spawn)
	queue_free()

func _on_Laser_area_entered(area):
	if area.is_in_group("orbullets"):	
		get_parent().emit_signal("hit_enemy", area.value) 
		area.die()
