extends Area2D

var projectile_speed = 500
var damage = 10

var direction: Vector2
# Called when the node enters the scene tree for the first time.
func launchProjectile(position, targetPosition):
	global_position = position
	direction = (targetPosition - position).normalized()

func _physics_process(delta):
	position += direction * projectile_speed * delta
