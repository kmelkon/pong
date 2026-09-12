@tool
extends CharacterBody2D


const SPEED := 500.0
const PADDLE_HALF_HEIGHT := 120.0
const MAX_BOUNCE_ANGLE := deg_to_rad(55.0)

signal left_goal_scored
signal right_goal_scored

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
	var collision := move_and_collide(velocity * delta)

	if not collision:
		return

	var collider := collision.get_collider() as Node2D

	if collider != null and collider.is_in_group("paddles"):
		var hit_offset: float = collision.get_position().y - collider.global_position.y
		var hit_fraction: float = clamp(hit_offset / PADDLE_HALF_HEIGHT, -1.0, 1.0)
		var angle: float = hit_fraction * MAX_BOUNCE_ANGLE

		# The collision normal determines which way is away from the paddle.
		var horizontal_direction: float = sign(collision.get_normal().x)
		velocity = Vector2(
			horizontal_direction * cos(angle),
			sin(angle)
		) * SPEED
	else:
		# Top/bottom walls.
		velocity = velocity.bounce(collision.get_normal())
		


func _on_left_goal_body_entered(body: Node2D) -> void:
	if body != self:
		return
	emit_signal("left_goal_scored")

func _on_right_goal_body_entered(body: Node2D) -> void:
	if body != self:
		return
	emit_signal("right_goal_scored")
