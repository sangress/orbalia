extends RigidBody2D

export (PackedScene) var Bullet
export (PackedScene) var Explosion

onready var muzzle = $bullet_point
onready var bullet_points = $bullet_points
onready var fire_sfx = $fire_sfx
onready var timer = $Timer
onready var explosion_positions = $explosion_positions

signal on_hit

var rng = RandomNumberGenerator.new()
var target
var speed = 75
var hp = 100

func _ready():
	rng.randomize()
	timer.start()

func _physics_process(delta):
	pass
#	global_position.angle_to_point(target.global_position)
#	look_at(target.position)
#	rotation

func _integrate_forces(state):
	angular_velocity += 0.01
	var vel = state.get_linear_velocity()
	state.set_linear_velocity(Vector2(0, 0))
#	if target != null:
		
#		SmoothLookAt(self, target.transform.origin, 100)

func fire():
	fire_sfx.play()
	var b = Bullet.instance()		
#	b.scale = Vector2(0.15, 0.15)
	b.speed = speed
	owner.add_child(b)		
	var exit_point = bullet_points.get_children()[rng.randi_range(0, bullet_points.get_child_count() - 1)]
	b.global_transform = exit_point.global_transform	

# fire timer
func _on_Timer_timeout():
	if timer.wait_time < 1:
		timer.wait_time -= 0.25
	fire()

func SmoothLookAt( nodeToTurn, targetPosition, turnSpeed ):
	nodeToTurn.transform = nodeToTurn.transform.interpolate_with(Transform2D(targetPosition.angle_to_point(nodeToTurn.position), nodeToTurn.position), turnSpeed)


func _on_speed_inc_timer_timeout():
	speed += 10


func _on_Flowerust_on_hit(dmg):
	hp -= dmg
	if hp <= 0:
		$explode.play()
		for n in explosion_positions.get_child_count():
			var explosion = Explosion.instance()
			explosion.position = explosion_positions.get_child(n).position
			add_child(explosion)
	target.emit_signal("hit_flower")
	get_parent().emit_signal("hit_flower")
