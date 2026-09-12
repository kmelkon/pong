extends Node2D

@onready var ball: CharacterBody2D = %Ball

enum RoundState { WAITING_TO_SERVE, IN_PLAY }

var round_state := RoundState.WAITING_TO_SERVE


func _physics_process(delta: float) -> void:
	if round_state == RoundState.WAITING_TO_SERVE:
		if Input.is_action_just_pressed("serve"):
			ball.serve()
			round_state = RoundState.IN_PLAY

func player_scored(scoring_player: int) -> void:
	# update score UI here
	ball.reset_to_center()
	round_state = RoundState.WAITING_TO_SERVE
