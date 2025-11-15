extends CharacterBody2D


var speed = 300.0
var hearts = 3

func read_input():
	var movement = Input.get_vector("left", "right", "up", "down")
	velocity = movement * speed;

func _physics_process(delta):
	read_input()
	move_and_slide()
