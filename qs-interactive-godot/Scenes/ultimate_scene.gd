# Ultimate Script.gd
extends Control

# ========== Introducing Nodes to the script ==========
@export var Main_to_comp_seq: AnimatedSprite2D
@export var Comp_to_chip_seq: AnimatedSprite2D
@export var Chipt_to_main_seq: AnimatedSprite2D

# ========== Introducing BUTTIONS to the script ==========
@export var Home_Button: Button
@export var ExploreComputer_Button: Button
@export var Chip_Button: Button
@export var HomeFromChip_Button: Button
@export var ReturnToComp_Button: Button

func _ready():
	# Hide buttons
	Home_Button.hide()
	HomeFromChip_Button.hide()
	Chip_Button.hide()
	ReturnToComp_Button.hide()
	
	# Hide Sprites
	Comp_to_chip_seq.hide()
	Chipt_to_main_seq.hide()

# ========== Button Functions ==========
func _on_explore_computer_pressed():
	# Show and play the animation
	# Main_to_comp_seq.visible = true
	Main_to_comp_seq.play()
	Home_Button.show()
	ExploreComputer_Button.hide()
	Chip_Button.show()

func _on_home_button_pressed():
	# Set to last frame
	
	Main_to_comp_seq.frame = Main_to_comp_seq.sprite_frames.get_frame_count(Main_to_comp_seq.animation) - 1
	
	# Play in reverse
	Main_to_comp_seq.speed_scale = -1
	Main_to_comp_seq.play()
	
	# Wait for animation to finish
	await Main_to_comp_seq.animation_finished
	Home_Button.hide()
	Chip_Button.hide()
	ExploreComputer_Button.show()
	# Reset speed scale for next forward play
	Main_to_comp_seq.speed_scale = 1


func _on_chip_button_pressed():
	# Hide first animation if it's visible
	Main_to_comp_seq.hide()
	
	# Show and play the second animation
	Comp_to_chip_seq.show()
	Comp_to_chip_seq.play()
	
	# Wait for animation to finish
	await Comp_to_chip_seq.animation_finished
	# Update button visibility
	Home_Button.hide()
	Chip_Button.hide()
	HomeFromChip_Button.show()
	ReturnToComp_Button.show()
	ExploreComputer_Button.hide()


func _on_exit_button_pressed():
	get_tree().quit()


func _on_return_to_comp_pressed() -> void:
	# Hide return button
	ReturnToComp_Button.hide()
	
	# Set to last frame of comp-to-chip animation
	Comp_to_chip_seq.frame = Comp_to_chip_seq.sprite_frames.get_frame_count(Comp_to_chip_seq.animation) - 1
	
	# Play in reverse
	Comp_to_chip_seq.speed_scale = -1
	Comp_to_chip_seq.play()
	
	# Wait for animation to finish
	await Comp_to_chip_seq.animation_finished
	
	# Hide this animation
	Comp_to_chip_seq.hide()
	
	# Show the main-to-comp animation (since we're back to computer view)
	Main_to_comp_seq.show()
	
	# Show appropriate buttons for computer state
	Home_Button.show()
	Chip_Button.show()
	HomeFromChip_Button.hide()
	# Reset speed scale for future plays
	Comp_to_chip_seq.speed_scale = 1


func _on_HomeFromChip_button_pressed() -> void:
	# Hide the return buttons
	ReturnToComp_Button.hide()
	HomeFromChip_Button.hide()
	
	# Hide current animation
	Comp_to_chip_seq.hide()
	
	# Show and play the chip-to-main animation
	Chipt_to_main_seq.show()
	Chipt_to_main_seq.play()
	
	# Wait for animation to finish
	await Chipt_to_main_seq.animation_finished
	
	# Hide this animation
	Chipt_to_main_seq.hide()
	
	# Set main-to-comp animation to first frame and show it
	Main_to_comp_seq.frame = 0
	Main_to_comp_seq.show()
	
	# Show only the buttons for main state
	ExploreComputer_Button.show()
	Home_Button.hide()
	Chip_Button.hide()
