extends Control

@export var resource_type: String = "Wood"
@export var show_name: bool = false

@onready var label: Label = $Label
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	setup_counter()
	# Mettre à jour le texte immédiatement
	update_display()
	# Se connecter au signal global
	Global.ressource_inventory_updated.connect(update_display)

func setup_counter():
	if Global.resource_data.has(resource_type):
		var data = Global.resource_data[resource_type]
		# Mise à jour automatique de la région de l'icône si le sprite existe
		if sprite:
			sprite.region_rect = data["icon_region"]
	else:
		print("Warning: Resource type '", resource_type, "' not found in Global.resource_data")

func update_display():
	if Global.ressource_inventory.has(resource_type):
		var amount = Global.ressource_inventory[resource_type]
		var display_text = str(amount)
		
		if show_name and Global.resource_data.has(resource_type):
			display_text = Global.resource_data[resource_type]["display_name"] + ": " + display_text
			
		label.text = display_text
	else:
		label.text = "N/A"
