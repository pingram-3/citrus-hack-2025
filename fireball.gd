extends Area2D

@export var projectile_speed = 500
@export var damage = 10

var direction: Vector2
var transformed := false

func _ready():
	$CharacterBody2D/afterexplosion.hide()
	connect("body_entered", Callable(self, "_on_body_entered"))

func launchProjectile(origin: Vector2, targetPosition: Vector2):
	global_position = origin
	direction = (targetPosition - origin).normalized()

func _physics_process(delta):
	if not transformed:
		global_position += direction * projectile_speed * delta

func _on_body_entered(body):
	if body.is_in_group("Enemy") and not transformed:
		body.take_damage(damage)
		damage_all_enemies()
		transformed = true
		projectile_speed = 0
		$CharacterBody2D/beforeexplosion.hide()
		$CharacterBody2D/afterexplosion.show()
		await get_tree().create_timer(0.4).timeout
		queue_free()

func damage_all_enemies():
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.take_damage(damage * 2)
