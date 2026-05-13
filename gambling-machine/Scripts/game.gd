extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('spin_left'):
		var base = 250.0
		
		# Reel 1: base * rand(1.0, 2.0)
		var power1 = base * randf_range(1.0, 2.0)
		$"Level/One-Armed Bandit".spin_the_wheels(0, power1)
		
		# Reel 2: 1st reel * 1.5 * rand(1.0, 1.5)
		var power2 = power1 * 1.5 * randf_range(1.0, 1.5)
		$"Level/One-Armed Bandit".spin_the_wheels(1, power2)
		
		# Reel 3: 2nd reel * 1.5 * rand(1.0, 1.5)
		var power3 = power2 * 1.5 * randf_range(1.0, 1.5)
		$"Level/One-Armed Bandit".spin_the_wheels(2, power3)
