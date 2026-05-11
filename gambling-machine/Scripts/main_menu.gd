extends Node3D

var game = preload("res://Scenes/game.tscn")

@export var target_path: NodePath
@export var rotation_speed: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Background/CameraPivot/Camera3D.look_at(Vector3(0,0,0))
	$Background/SpotLight3D.look_at(Vector3(0,0,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# 2. Rotate the pivot to "hover" around
	$Background/CameraPivot.rotate_y(rotation_speed * delta)

func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(game)
