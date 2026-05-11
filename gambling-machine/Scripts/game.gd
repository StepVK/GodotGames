extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('spin_left'):
		$"Level/One-Armed Bandit".spin_the_wheels(0,0.5)
	if event.is_action_pressed('spin_middle'):
		$"Level/One-Armed Bandit".spin_the_wheels(1,0.5)
	if event.is_action_pressed('spin_right'):
		$"Level/One-Armed Bandit".spin_the_wheels(2,0.5)
