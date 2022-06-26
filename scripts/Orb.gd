extends RigidBody2D

export (int) var engine_thrust
export (int) var spin_thrust
export (PackedScene) var Bullet
export (PackedScene) var Explosion

signal on_hit
signal hit_flower
signal collect_orb

onready var muzzle = $muzzle
onready var fire_sfx = $fire_sfx
onready var cam = $Camera2D

var orbs = 0
var hp = 10
var thrust = Vector2(1500, 0)
var rotation_dir = 0
var screensize
var slowdown = 100
var is_thrust = false
var wheel_dir = "down";
var WHEEL_DIRS = {
	down = BUTTON_WHEEL_DOWN,
	up = BUTTON_WHEEL_UP
}

func _ready():
	screensize = get_viewport().get_visible_rect().size

func get_input():
	if Input.is_action_pressed("left"):
		thrust = Vector2(engine_thrust, 0)
	else:
		thrust = Vector2(0, 0)
	
	if Input.is_action_pressed("right"):
		if linear_velocity.x < 100:
			thrust = Vector2(thrust.x - slowdown, 0)	

func _process(delta):
	get_input()

func _physics_process(delta):
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(rotation_dir * spin_thrust)

func _input(event):
	if Input.is_action_just_pressed("fire"):
		fire()

func _unhandled_input(event):	
#	rotation_dir = lerp(rotation_dir, 0, 0.8)
	rotation_dir = 0
	if event is InputEventMouseButton:
		if wheel_dir == 'down':
			if event.button_index == BUTTON_WHEEL_UP:
				rotation_dir = 1
			if event.button_index == BUTTON_WHEEL_DOWN:
				rotation_dir = -1
		else:
			if event.button_index == BUTTON_WHEEL_UP:
				rotation_dir = -1
			if event.button_index == BUTTON_WHEEL_DOWN:
				rotation_dir = 1		

func fire():
	fire_sfx.play()
	var b = Bullet.instance()	
	owner.add_child(b)
	b.global_transform = muzzle.global_transform	
	
func set_wheel_dir(newDir):
	wheel_dir = newDir



func _on_Orb_on_hit(dmg):
	cam.add_trauma(0.5)
	hp -= dmg
	if hp <= 0:
		$explode_sfx.play()
		var explosion = Explosion.instance()
		explosion.position = $explocde_position.position
		add_child(explosion)
		get_parent().reset_level()


func _on_Orb_hit_flower():
	cam.add_trauma(0.2)


func _on_Orb_collect_orb():
	orbs += 1
