extends StaticBody2D

var is_placed: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready():
	# Initially, collision is disabled while we are placing it
	collision.disabled = true
	# Give it some transparency to show it's a "ghost"
	modulate.a = 0.5

func _process(_delta):
	if not is_placed:
		# Follow the mouse cursor
		global_position = get_global_mouse_position()

func place():
	is_placed = true
	collision.disabled = false
	modulate.a = 1.0
	# Set the Z index or layer if necessary to ensure it's behind/in front of things
	z_index = int(global_position.y) 
