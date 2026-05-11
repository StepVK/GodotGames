extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set angular damp to ensure natural slowdown
	$Reel_cylinder.angular_damp = 5.0
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Optional: check if spinning has stopped to report it
	pass
	
func spin_the_wheel(spin_power):
	# Vector3(X, Y, Z) - apply torque along the rotation axis (World X or Z based on setup)
	# The setup uses the X-axis for rotation
	randomize()
	var torque = Vector3(spin_power + randf_range(-10, 10), 0, 0)
	
	$Reel_cylinder.apply_torque_impulse(torque)
