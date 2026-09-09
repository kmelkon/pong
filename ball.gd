@tool
extends CharacterBody2D


const SPEED = 300.0
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

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
