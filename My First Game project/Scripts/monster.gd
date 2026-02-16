extends RigidBody2D

const MAX_HEALTH = 2
const START_PLAYER_ATTRACTION = 0.1
const ATTRACTION_PER_SECOND = 0.01

var player_attraction = START_PLAYER_ATTRACTION
var stored_delta = 0
var health = MAX_HEALTH
var seconds_in_game = 0

signal died
signal damaged

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Enemies")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	seconds_in_game += delta
	# Reverse gravity every
	stored_delta += delta
	if stored_delta >= 0.1:
		gravity_scale *= -1
		push_towards_player()
		stored_delta -= 0.1

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Bullets"):
		health -=1
		damaged.emit()
	if health <= 0:
		process_enemy_death()
		queue_free()

func push_towards_player() -> void:
	var player = get_parent().get_node("Player")
	if player == null:
		return
	var impulse = (player.position - position) * (player_attraction + ATTRACTION_PER_SECOND * seconds_in_game)
	apply_impulse(impulse)
	
func process_enemy_death():
	died.emit()
