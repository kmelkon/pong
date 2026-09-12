extends Node2D

@onready var ball: CharacterBody2D = %Ball

enum RoundState { WAITING_TO_SERVE, IN_PLAY }

var round_state := RoundState.WAITING_TO_SERVE

# listen on left_goal_scored
func _ready() -> void:
	ball.connect("left_goal_scored", Callable(self, "player_scored").bind(1))
	ball.connect("right_goal_scored", Callable(self, "player_scored").bind(2))

func _physics_process(delta: float) -> void:
	if round_state == RoundState.WAITING_TO_SERVE:
		if Input.is_action_just_pressed("serve"):
			ball.serve()
			round_state = RoundState.IN_PLAY

func player_scored(scoring_player: int) -> void:
	# update score UI here
	ball.reset_to_center()
	round_state = RoundState.WAITING_TO_SERVE
	print("Player ", scoring_player, " scored!")
