# compute_dive.gd
extends Control

# === Nodes ===
@export var Exit_Button : TextureButton
@export var back_button : TextureButton
@export var MaintoComputeAnimation : AnimatedSprite2D

# === Scenes ===
var selection_scene = null  # For going back
var deeper_dive_scene = null  # For diving deeper


# === Functions ====

func _ready():
	# Connect the back button signal
	back_button.pressed.connect(_on_Back_Button_pressed)
	Exit_Button.pressed.connect(_on_exit_button_pressed)
	# Play the animation forward when entering the scene
	MaintoComputeAnimation.play("default")
	MaintoComputeAnimation.animation_finished.connect(_on_animation_forward_finished)
	call_deferred("_preload_scenes") # pre-load both scenes

func _on_animation_forward_finished():
	MaintoComputeAnimation.animation_finished.disconnect(_on_animation_forward_finished)
	var last_frame = MaintoComputeAnimation.sprite_frames.get_frame_count("default") - 1
	MaintoComputeAnimation.frame = last_frame

func _on_Back_Button_pressed():
	# First play the animation in reverse
	MaintoComputeAnimation.speed_scale = -1  # Negative speed plays in reverse
	MaintoComputeAnimation.frame = MaintoComputeAnimation.sprite_frames.get_frame_count("default") - 1  # Start from the last frame
	MaintoComputeAnimation.play("default")
	
	# Connect to the animation_finished signal for the reverse playback
	MaintoComputeAnimation.animation_finished.connect(_on_animation_reverse_finished)

func _on_animation_reverse_finished():
	# Switch back to the main scene using the preloaded scene
		if selection_scene:
			get_tree().change_scene_to_packed(selection_scene)
		else:
			# Fallback
			get_tree().change_scene_to_file("res://Scenes/selection_scene.tscn")

func _preload_scenes():
	# Preload the scene to return to
	selection_scene = load("res://Scenes/selection_scene.tscn")
	
	## Preload the deeper dive scene
	#deeper_dive_scene = load("res://Scenes/path_to_deeper_dive_scene.tscn")
	#print("All scenes preloaded and ready!")

func _on_exit_button_pressed():
	get_tree().quit()
