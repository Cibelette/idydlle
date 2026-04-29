extends Node2D

var current_placing_item = null

@onready var world_node = $Background # Or create a dedicated 'World' node

func _on_crafting_menu_item_crafted(item_node):
	if current_placing_item != null:
		# If already placing something, maybe cancel it or just replace?
		# For now, let's just allow one at a time.
		current_placing_item.queue_free()
	
	current_placing_item = item_node
	add_child(current_placing_item)
	print("Started placement of ", item_node.name)

func _input(event):
	if current_placing_item != null:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			finalize_placement()
		elif event.is_action_pressed("ui_cancel"): # Press ESC to cancel placement
			cancel_placement()

func finalize_placement():
	if current_placing_item.has_method("place"):
		current_placing_item.place()
		print("Placed ", current_placing_item.name)
		current_placing_item = null
	else:
		print("Error: Item does not have a 'place' method")

func cancel_placement():
	if current_placing_item != null:
		# Optionally refund resources here?
		current_placing_item.queue_free()
		current_placing_item = null
		print("Placement cancelled")
