extends Control

signal item_crafted(item_node)

@onready var crafting_panel = $CraftingPanel
@onready var furniture_scene = preload("res://Scenes/Furniture.tscn")

func _ready():
	# Start with the panel hidden
	crafting_panel.visible = false

func _input(event):
	# Toggle with keyboard shortcut 'C'
	if event.is_action_pressed("toggle_crafting"):
		toggle_menu()

func toggle_menu():
	crafting_panel.visible = !crafting_panel.visible
	if crafting_panel.visible:
		print("Crafting Menu Opened")

func _on_open_button_pressed():
	toggle_menu()

func _on_craft_chest_pressed():
	var cost = 10
	if Global.spend_resource("Wood", cost):
		var new_furniture = furniture_scene.instantiate()
		item_crafted.emit(new_furniture)
		# Hide menu after crafting to allow placement
		crafting_panel.visible = false
	else:
		print("Not enough Wood to craft Chest!")
