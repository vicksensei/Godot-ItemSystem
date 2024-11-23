extends Button

@export var item:invItem
@export var quantity:int
@export var chest:Chest

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Add " + str(quantity)+ " " + item.itemName
	icon = item.icon
	pass # Replace with function body.

func add():
	var result = chest.addItem(item,quantity)
	print(result)
	if result == true:
		print("Successfully added " + str(quantity)+ " " + item.itemName)
	if result == false:
		print("Not enough room for "  + str(quantity)+ " " + item.itemName)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	add()
	pass # Replace with function body.
