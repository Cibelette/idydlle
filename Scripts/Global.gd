@tool
extends Node

signal ressource_inventory_updated
# Dictionnaire centralisant les informations sur les ressources
var resource_data = {
	"Wood": {
		"display_name": "Bois",
		"icon_region": Rect2(16, 16, 16, 16) # Région dans le sprite sheet
	},
	"Berry": {
		"display_name": "Baies",
		"icon_region": Rect2(32, 16, 16, 16)
	},
	"Stone": {
		"display_name": "Pierre",
		"icon_region": Rect2(48, 16, 16, 16)
	}
}

# A Dictionary is perfect for keeping track of multiple resource types
var ressource_inventory = {
	"Wood": 0,
	"Berry": 0,
	"Stone": 0
}

var grid_size: int = 16

func snap_to_grid(pos: Vector2) -> Vector2:
	return (pos / grid_size).floor() * grid_size + Vector2(grid_size / 2.0, grid_size / 2.0)


func add_resource(type: String, amount: int):
	if ressource_inventory.has(type):
		ressource_inventory[type] += amount
		print("Gained ", amount, " ", type, "! Total: ", ressource_inventory[type])
		# This is where you would tell your HUD to update its text
		ressource_inventory_updated.emit()
		
	else:
		print("Error: Resource type '", type, "' doesn't exist in inventory!")

func spend_resource(type: String, amount: int) -> bool:
	if ressource_inventory.has(type):
		if ressource_inventory[type] >= amount:
			ressource_inventory[type] -= amount
			print("Spent ", amount, " ", type, "! Remaining: ", ressource_inventory[type])
			ressource_inventory_updated.emit()
			return true
		else:
			print("Not enough ", type, "!")
			return false
	else:
		print("Error: Resource type '", type, "' doesn't exist in inventory!")
		return false
