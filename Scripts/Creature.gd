extends CharacterBody2D

class_name Creature

# Dictionnaire des créatures avec leurs données
var creature_types = {
	"cat": {
		"name": "Cat",
		"scene": "res://Scenes/cat.tscn",
		"resource": "Wood",
		"amount": 1,
		"sound": "Meow!"
	},
	"chicken": {
		"name": "Chicken",
		"scene": "res://Scenes/chicken.tscn",
		"resource": "Berry", # On peut changer pour "Egg" si ajouté plus tard
		"amount": 2,
		"sound": "Cluck!"
	}
}

@export var creature_type: String = "cat"
@export var habitat: Node2D
@export var wander_radius: float = 100.0
@export var movement_speed: float = 50.0

var target_position: Vector2
var is_moving: bool = false

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var production_timer: Timer = $Timer # On réutilise le timer existant dans la scène

func _ready():
	# Configuration de la production toutes les 10 secondes
	if production_timer:
		production_timer.wait_time = 10.0
		production_timer.start()
	
	await get_tree().process_frame
	await get_tree().process_frame
	
	if habitat:
		print("[Creature] Habitat trouvé : ", habitat.global_position)

func _on_timer_timeout():
	if creature_types.has(creature_type):
		var data = creature_types[creature_type]
		Global.add_resource(data["resource"], 10 * data["amount"])
		print(data["name"], " dit : ", data["sound"])
	else:
		# Comportement par défaut si le type n'est pas dans le dictionnaire
		Global.add_resource("Wood", 1)
		print("Une créature inconnue produit du bois...")

func setup_creature():
	# Cette fonction peut être appelée pour initialiser spécifiquement si besoin
	pass
	
