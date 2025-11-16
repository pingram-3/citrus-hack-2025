extends CharacterBody2D


var speed = 300.0
var hearts = 3
@export var fire_rate := 0.2
@export var selected_ability := "fireball"
@export var ability_cooldown := 1.0
var can_use_ability := true
var isShooting = false
var targetPosition: Vector2
var shootDirection: Vector2
var preloadm1 = preload("res://projectile.tscn")

var ability_projectiles := {
	"fireball": preload("res://fireball.tscn"),
	# add lightning, ice, etc later
}

func read_input():
	var movement = Input.get_vector("left", "right", "up", "down")
	velocity = movement * speed;

func _physics_process(delta):
	read_input()
	move_and_slide()
	_shoot()
	_secondspell()

func _shoot():
	if Input.is_action_just_pressed("left click") and not isShooting:
		isShooting = true
		
		targetPosition = get_global_mouse_position()
		shootDirection = (targetPosition - global_position).normalized()

		var m1 = preloadm1.instantiate()
		m1.launch_projectile(global_position, targetPosition)
		get_parent().add_child(m1)

		await get_tree().create_timer(fire_rate).timeout
		isShooting = false
		
func _secondspell():
	if not Input.is_action_just_pressed("right click"):
		return

	if selected_ability == "none":
		return

	if not can_use_ability:
		return

	var scene = ability_projectiles.get(selected_ability, null)
	if scene == null:
		return

	can_use_ability = false

	var ability_proj = scene.instantiate()
	var target = get_global_mouse_position()
	ability_proj.launchProjectile(global_position, target)
	get_parent().add_child(ability_proj)

	# cooldown timer
	await get_tree().create_timer(ability_cooldown).timeout
	can_use_ability = true
