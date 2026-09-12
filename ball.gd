@tool
extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -400.0

@export var radius: float = 50.0:
	set(value):
		radius = value
		queue_redraw() # Redraws instantly when you change the slider!

@export var circle_color: Color = Color.WHITE:
	set(value):
		circle_color = value
		queue_redraw()

func _ready() -> void:
	queue_redraw() 

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, circle_color)

func serve() -> void:
	velocity.x = SPEED if randi() % 2 == 0 else -SPEED
	velocity.y = (randf() - 0.5) * SPEED

func reset_to_center() -> void:
	global_position = Vector2(960, 540)
	velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	move_and_slide()
