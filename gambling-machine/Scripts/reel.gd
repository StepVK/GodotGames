extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set angular damp to ensure natural slowdown
	# Add slight randomization to damp for each reel to differentiate spin behavior
	$Reel_cylinder.angular_damp = 1.0 + randf_range(-0.2, 0.2)
	
	# Add slight randomization to mass
	$Reel_cylinder.mass = 1.0 + randf_range(-0.1, 0.1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if abs($Reel_cylinder.angular_velocity.x) < 0.5 and $Reel_cylinder.angular_velocity.x != 0:
		var current_rotation = $Reel_cylinder.rotation.x
		var angle_per_icon = PI / 4
		var nearest_angle = round(current_rotation / angle_per_icon) * angle_per_icon

		$Reel_cylinder.angular_damp = 20.0
		
		# If it's close enough, stop it
		if abs(current_rotation - nearest_angle) < 0.05 and abs($Reel_cylinder.angular_velocity.x) < 0.1:
			$Reel_cylinder.angular_velocity = Vector3.ZERO
			$Reel_cylinder.angular_damp = 1.0 + randf_range(-0.2, 0.2)
			$Reel_cylinder.rotation.x = nearest_angle
	
func spin_the_wheel(spin_power):
	# Vector3(X, Y, Z) - apply torque along the rotation axis (World X or Z based on setup)
	# The setup uses the X-axis for rotation
	var torque = Vector3(spin_power + randf_range(-10, 10), 0, 0)
	
	# Reset damp on new spin
	$Reel_cylinder.angular_damp = 1.0 + randf_range(-0.2, 0.2)
	
	$Reel_cylinder.apply_torque_impulse(torque)
