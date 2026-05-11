extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spin_the_wheels(which: int, power: float):
	if which == 0:
		$Base/Reel.spin_the_wheel(power)
	elif which == 1:
		$Base/Reel2.spin_the_wheel(power)
	elif which == 2:
		$Base/Reel3.spin_the_wheel(power)
	else:
		pass
