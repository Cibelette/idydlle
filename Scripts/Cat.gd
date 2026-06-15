extends CharacterBody2D

# This allows you to drag and drop your .tres files (Rabbit, Bear, etc.) in the Inspector
@export var creature_info: CreatureData 

@export var habitat: Node2D # The Tree or habitat node this creature belongs to
@export var wander_radius: float = 100.0
@export var movement_speed: float = 50.0

var target_position: Vector2
var is_moving: bool = false

@onready var timer: Timer = $Timer
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	if creature_info:
		setup_creature()
	else:
		print("Warning: No CreatureData assigned to this scene!")
	
	# Connect the avoidance signal

	
	# Wait for the whole scene tree AND navigation map to be ready
	await get_tree().process_frame
	await get_tree().process_frame # Double frame wait for safety
	
	if habitat:
		print("[Cat] Habitat found at global: ", habitat.global_position)
		
		
	else:
		print("[Cat] Warning: No habitat assigned!")



func _on_timer_timeout():
	# Access our Global script to add the resources
	# Note: We assume Global.gd has a function called 'add_resource'
	Global.add_resource(creature_info.resource_type, creature_info.produce_amount)

func setup_creature():
	timer.wait_time = creature_info.produce_time
	timer.start()
	nav_agent.avoidance_enabled = true
	
