extends Node2D

const START_MAX_CHICKEN = 10
const MAX_CHICKEN_PER_SEC = 0.1
var max_chicken = START_MAX_CHICKEN
var time_since_last_chicken = 0
const CHICKEN = preload("res://Scenes/monster.tscn")
var score = 0
var time_since_start = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_last_chicken += delta
	time_since_start += delta
	if time_since_last_chicken >= 1:
		if get_tree().get_nodes_in_group("Enemies").size() < max_chicken + time_since_start * MAX_CHICKEN_PER_SEC:
			spawn_chicken()
			time_since_last_chicken = 0

func spawn_chicken():
	var player = $Player
	if player == null:
		return
	var spawn_point_x = randf_range(player.position.x - 450, player.position.x + 450)
	var spawn_point_y = randf_range(player.position.y - 450, player.position.y - 550)
	var chicken = CHICKEN.instantiate()
	add_child(chicken)
	chicken.died.connect(_on_chicken_died)
	
	chicken.position.x = spawn_point_x
	chicken.position.y = spawn_point_y
	
	print("A worthy enemy appears!")
	
func _on_chicken_died():
	score += 1


func _on_button_exit_pressed() -> void:
	get_tree().quit()


func _on_player_died() -> void:
	var game_over_container = $CanvasLayer/GameOverContainer
	var score_label = $CanvasLayer/GameOverContainer/Label2
	score_label.text = "FINAL SCORE: " + str(score)
	game_over_container.visible = true
