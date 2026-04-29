extends Node

signal ressource_inventory_updated
# A Dictionary is perfect for keeping track of multiple resource types
var ressource_inventory = {
	"Wood": 0,
	"Berry": 0,
	"Stone": 0
}


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
