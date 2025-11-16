extends CharacterBody2D


var speed = 500.0
var hearts = 3
@export var fire_rate := 0.2
var isShooting = false
var targetPosition: Vector2
var shootDirection: Vector2
var preloadm1 = preload("res://projectile.tscn")

func read_input():
	var movement = Input.get_vector("left", "right", "up", "down")
	velocity = movement * speed;

func _physics_process(delta):
	read_input()
	move_and_slide()
	_shoot()

func _shoot():
	if Input.is_action_just_pressed("left click") and not isShooting:
		isShooting = true
		
		targetPosition = get_global_mouse_position()
		shootDirection = (targetPosition - global_position).normalized()

		var m1 = preloadm1.instantiate()
		m1.launchProjectile(global_position, targetPosition)
		get_parent().add_child(m1)

		await get_tree().create_timer(fire_rate).timeout
		isShooting = false
