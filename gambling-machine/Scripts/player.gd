extends CharacterBody3D


const SPEED_WALK = 6.0
const SPEED_RUN = 10.0
var speed = 0.0
const JUMP_VELOCITY = 4.5
const SENS = 0.005
const STEP_HEIGHT = 0.1

const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

@onready var head = $Head
@onready var camera = $Head/Camera3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENS)
		camera.rotate_x(-event.relative.y * SENS)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50), deg_to_rad(70))
		
	if event.is_action('quit'):
		get_tree().quit()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("sprint"):
		speed = SPEED_RUN
	else:
		speed = SPEED_WALK

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction: Vector3 = Vector3.ZERO
	direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = 0.0
			velocity.z = 0.0
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3)
		
	# head bobbing
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	move_and_slide()
	if is_on_wall() and direction:
		handle_step_up(delta, direction)
	
func handle_step_up(_delta: float, direction: Vector3) -> void:
	# this func is pure garbage, don't reuse
	print("Checking for step")
	var up_vec = Vector3.UP * STEP_HEIGHT
	var forward_vec = direction * STEP_HEIGHT

	move_and_collide(up_vec, true) # 'true' means it's just a test
	move_and_collide(forward_vec, true)

	var final_pos = global_position + up_vec + forward_vec
	global_position = final_pos
	move_and_collide(-up_vec)

	move_and_slide()
	
func  _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
