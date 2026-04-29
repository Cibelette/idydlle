extends Label

func _ready():
	# 1. Update the text immediately when the game starts
	update_display()
	
	# 2. Tell the Global script: "Whenever you shout 'inventory_updated', run my update_display function"
	Global.inventory_updated.connect(update_display)

func update_display():
	# Get the number from the Global brain and show it
	text = "Wood: " + str(Global.inventory["Wood"])
