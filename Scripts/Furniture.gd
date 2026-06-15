extends StaticBody2D

var is_placed: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready():
	# Initially, collision is disabled while we are placing it
	collision.disabled = true
	# Give it some transparency to show it's a "ghost"
	modulate.a = 0.5

func place():
	is_placed = true
	collision.disabled = false
	modulate.a = 1.0
	# Set the Z index or layer if necessary to ensure it's behind/in front of things
	z_index = int(global_position.y) 
	
	# Update navigation obstacle if it exists
	var obstacle = get_node_or_null("NavigationObstacle2D")
	if obstacle:
		obstacle.avoidance_enabled = true
