extends Node

signal inventory_updated
# A Dictionary is perfect for keeping track of multiple resource types
var inventory = {
	"Wood": 0,
	"Berry": 0,
	"Stone": 0
}


func add_resource(type: String, amount: int):
	if inventory.has(type):
		inventory[type] += amount
		print("Gained ", amount, " ", type, "! Total: ", inventory[type])
		# This is where you would tell your HUD to update its text
		inventory_updated.emit()
		
	else:
		print("Error: Resource type '", type, "' doesn't exist in inventory!")
