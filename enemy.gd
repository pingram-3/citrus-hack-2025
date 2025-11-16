extends CharacterBody2D
@onready var target= get_node("/root/Main/Player")

var speed = 50
var destroy_distance = 157 
var health = 30

func _ready():
	add_to_group("Enemy")

func take_damage(amount):
	health -= amount
	if health <=0:
		queue_free()

func _physics_process(delta):
	var direction=(target.position - global_position).normalized()
	velocity = direction * speed
	look_at(target.position)
	move_and_slide()
	if position.distance_to(target.position) < destroy_distance:
		queue_free()
