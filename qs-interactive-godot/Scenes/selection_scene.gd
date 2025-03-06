extends Control

# Will hold our preloaded scene
var computer_dive_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("_preload_next_scene")

func _preload_next_scene():
	# Load the scene in the background
	computer_dive_scene = load("res://Scenes/02_Computer_Dive/computer_dive.tscn")
	print("Next scene preloaded and ready!")

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_explore_computer_pressed() -> void:
	if computer_dive_scene:
		# Use the preloaded scene
		get_tree().change_scene_to_packed(computer_dive_scene)
	else:
		# Fallback in case preloading isn't done yet
		get_tree().change_scene_to_file("res://Scenes/02_Computer_Dive/computer_dive.tscn")
