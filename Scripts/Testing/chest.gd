extends Button
class_name Chest

const INVENTORY_CONTAINER = preload("res://Blueprints/inventoryContainer.tscn")
var chestContents: InventoryData
var UI:InventoryContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	chestContents = InventoryData.new(5)
	UI=	INVENTORY_CONTAINER.instantiate()
	add_child(UI)
	UI.visible= false
	UI.setInvenventory(chestContents)
	UI.position = Vector2(0,200)
	pass # Replace with function body.

func toggleVisible():
	UI.visible = !UI.visible

func addItem(item, quantity):
	UI.visible = true
	var result = chestContents.addItem(item, quantity)
	UI.updateSlots()
	return result

func _on_pressed():
	toggleVisible()
	pass # Replace with function body.
