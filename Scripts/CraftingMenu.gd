extends Control

signal item_crafted(item_node)

@onready var crafting_panel = $CraftingPanel
@onready var item_list = $CraftingPanel/VBoxContainer

# Dictionary to store item data: cost and scene path
var craftable_items = {
	"Chest": {
		"display_name": "Wooden Chest",
		"cost": 10,
		"scene": preload("res://Scenes/chest.tscn")
	},
	"Table": {
		"display_name": "Wooden Table",
		"cost": 15,
		"scene": preload("res://Scenes/Table.tscn")
	},
	"Stool": {
		"display_name": "Wooden Stool",
		"cost": 0,
		"scene": preload("res://Scenes/stool.tscn")
	}
	
}

func _ready():
	crafting_panel.visible = false
	setup_menu()

func setup_menu():
	# Clear existing placeholder buttons (except Title and Separator)
	for child in item_list.get_children():
		if child is Button:
			child.queue_free()
	
	# Create buttons for each craftable item
	for item_id in craftable_items:
		var item_data = craftable_items[item_id]
		var btn = Button.new()
		btn.text = "%s (%d Wood)" % [item_data["display_name"], item_data["cost"]]
		btn.pressed.connect(func(): craft_item(item_id))
		item_list.add_child(btn)

func _input(event):
	if event.is_action_pressed("toggle_crafting"):
		toggle_menu()

func toggle_menu():
	crafting_panel.visible = !crafting_panel.visible

func _on_open_button_pressed():
	toggle_menu()

# Generic crafting function
func craft_item(item_id: String):
	var item_data = craftable_items[item_id]
	if Global.spend_resource("Wood", item_data["cost"]):
		var new_item = item_data["scene"].instantiate()
		item_crafted.emit(new_item)
		crafting_panel.visible = false
	else:
		print("Not enough Wood to craft ", item_id)
		
		
