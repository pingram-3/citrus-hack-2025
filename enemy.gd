extends CharacterBody2D
@onready var target=$"../Player"

var speed = 50
var destroy_distance = 157  # tweak as needed

func _physics_process(delta):
	var direction=(target.position - position).normalized()
	velocity = direction * speed
	look_at(target.position)
	move_and_slide()
	if position.distance_to(target.position) < destroy_distance:
		queue_free()
