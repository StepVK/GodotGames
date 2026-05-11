extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spin_the_wheel(spin_power):
	# Vector3(X, Y, Z) - adjust based on your reel's orientation
	# If your axle goes through the X axis, apply torque on X
	var torque = Vector3(spin_power + randf_range(-10, 10), 0, 0)
	
	$Reel_cylinder.apply_torque_impulse(torque)
