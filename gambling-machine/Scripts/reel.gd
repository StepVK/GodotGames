extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set angular damp to ensure natural slowdown
	# Add slight randomization to damp for each reel to differentiate spin behavior
	$Reel_cylinder.angular_damp = 1.0 + randf_range(-0.2, 0.2)
	
	# Add slight randomization to mass
	$Reel_cylinder.mass = 1.0 + randf_range(-0.1, 0.1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var speed = abs($Reel_cylinder.angular_velocity.x)
	
	# If we are in the slow-speed "cruising" range, check for stopping point
	if speed < 1.5 and speed > 0.1:
		var current_rotation = fmod($Reel_cylinder.rotation.x, 2 * PI)
		if current_rotation < 0:
			current_rotation += 2 * PI
			
		var angle_per_icon = PI / 4
		var half_angle = angle_per_icon / 2.0
		var remainder = fmod(current_rotation, angle_per_icon)
		
		# If we are passing the center of a symbol
		# The center is at half_angle (PI / 8)
		if abs(remainder - half_angle) < 0.05:
			$Reel_cylinder.angular_velocity = Vector3.ZERO
			# Reset damp to normal values
			$Reel_cylinder.angular_damp = 1.0 + randf_range(-0.2, 0.2)
	
func spin_the_wheel(spin_power):
	# Vector3(X, Y, Z) - apply torque along the rotation axis (World X or Z based on setup)
	# The setup uses the X-axis for rotation
	var torque = Vector3(spin_power + randf_range(-10, 10), 0, 0)
	
	# Reset damp on new spin
	$Reel_cylinder.angular_damp = 1.0 + randf_range(-0.2, 0.2)
	
	$Reel_cylinder.apply_torque_impulse(torque)
