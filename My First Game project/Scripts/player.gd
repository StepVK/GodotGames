extends CharacterBody2D


const SPEED = 300.0
const BULLET_SPEED = 10.0
const JUMP_VELOCITY = -500.0
const BULLET = preload("res://Scenes/bullet.tscn")
const MAX_HEALTH = 10
const INVUL_WINDOW = 0.2
const SHOOT_WINDOW = 0.5

var health = MAX_HEALTH
var invulnerable = false
var invulnerable_timer = 0
var shoot_timer = 0
var is_on_cooldown = false

signal died()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed('shoot'):
		if not is_on_cooldown:
			shoot()
			is_on_cooldown = true
			shoot_timer = SHOOT_WINDOW
	if shoot_timer > 0:
		shoot_timer -= delta
	if shoot_timer <= 0:
		shoot_timer = 0
		is_on_cooldown = false
	if invulnerable_timer > 0:
		invulnerable_timer -= delta
	if invulnerable_timer <= 0:
		invulnerable_timer = 0
		invulnerable = false
		
func shoot():
	shoot_from_to($AnimatedSprite2D/LeftEye.global_position, get_global_mouse_position())
	shoot_from_to($AnimatedSprite2D/RightEye.global_position, get_global_mouse_position())
	
func shoot_from_to(from: Vector2, to: Vector2):
	var bullet = BULLET.instantiate()
	get_parent().add_child(bullet)
	bullet.position = from
	bullet.add_constant_force((to - from) * BULLET_SPEED)
	
func receive_damage(damage: int):
	if invulnerable:
		pass
	health -= damage
	if health <= 0:
		die()
	invulnerable = true
	invulnerable_timer = INVUL_WINDOW
		
func die() -> void:
	print("You have died")
	queue_free()
	died.emit()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		receive_damage(1)
