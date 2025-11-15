extends Area2D

@export var continuous_cd = true
var projectile_speed = 500
var damage = 10
var direction: Vector2

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("body_entered", Callable(self, "_on_body_entered"))

func launchProjectile(origin: Vector2, targetPosition: Vector2):
	global_position = origin
	direction = (targetPosition - origin).normalized()

func _physics_process(delta):
	global_position += direction * projectile_speed * delta

func _on_Area2D_area_entered(area):
	if area.is_in_group("Enemy"):
		area.take_damage(damage)
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.take_damage(damage)
		queue_free()
