extends CharacterBody2D

# This allows you to drag and drop your .tres files (Rabbit, Bear, etc.) in the Inspector
@export var creature_info: CreatureData 

@onready var timer: Timer = $Timer
#@onready var sprite: Sprite2D = $Sprite2D
#@onready var label: Label = $NameLabel

func _ready():
	# 1. Check if we actually assigned data to this creature
	if creature_info:
		setup_creature()
	else:
		print("Warning: No CreatureData assigned to this scene!")

func setup_creature():

	
	# 3. Configure the timer based on the data
	timer.wait_time = creature_info.produce_time
	timer.start()

# 4. This function runs every time the Timer hits 0
func _on_timer_timeout():
	# Access our Global script to add the resources
	# Note: We assume Global.gd has a function called 'add_resource'
	Global.add_resource(creature_info.resource_type, creature_info.produce_amount)
	
