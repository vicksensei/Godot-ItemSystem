extends Control
class_name InventoryContainer

@onready var grid_container = $Panel/MarginContainer/GridContainer
@onready var panel = $Panel
@onready var margin_container = $Panel/MarginContainer

var invData: InventoryData
var slots:Array[ItemSlotUI] = []
const slot_blueprint = preload("res://Blueprints/item_slot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#resetSlots()
	pass

func setInvenventory(newInv:InventoryData):
	invData = newInv
	loadSlots();
	pass
func loadSlots():
	slots = []
	for i in range(invData.slots.size()):
		var newSlot:ItemSlotUI = slot_blueprint.instantiate()
		newSlot.slotID = i		
		grid_container.add_child(newSlot)
		newSlot.setSlot(invData.slots[i])
		slots.append(newSlot)	
	margin_container.size = grid_container.get_minimum_size()
	panel.size = margin_container.size	

func updateSlots():
	for s in slots:
		s.updateSlot()
		
func resetSlots():
	slots = []
	clear_children(grid_container)
	for i in range(invData.slots.size()):
		var newSlot:ItemSlotUI = slot_blueprint.instantiate()
		newSlot.slotID = i
		grid_container.add_child(newSlot)
		slots.append(newSlot)
	margin_container.size = grid_container.get_minimum_size()
	panel.size = margin_container.size
	

func clear_children(parent): 
	for child in parent.get_children(): 
		child.queue_free()
