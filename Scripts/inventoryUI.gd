extends Control
class_name InventoryContainer

@onready var grid_container = $Panel/MarginContainer/GridContainer
@onready var panel = $Panel
@onready var margin_container = $Panel/MarginContainer

@export var slotsNum:int
var slots:Array[ItemSlot] = []
var slot_blueprint = preload("res://Blueprints/item_slot.tscn")

signal containerFull

# Called when the node enters the scene tree for the first time.
func _ready():
	resetSlots()

func resetSlots():
	slots = []
	clear_children(grid_container)
	for i in range(slotsNum):
		var newSlot:ItemSlot = slot_blueprint.instantiate()
		newSlot.slotID = i
		grid_container.add_child(newSlot)
		slots.append(newSlot)
	margin_container.size = grid_container.get_minimum_size()
	panel.size = margin_container.size
	

func clear_children(parent): 
	for child in parent.get_children(): 
		child.queue_free()


func addItem(item:invItem, amount:int):
	var selectedSlot:ItemSlot = null
	#Check if you have an incomplete stack in every slot
	for s in slots:
		var i = s.heldItem
		if i .itemID == item.itemID and amount +s.quantity >= i.maxStack:
			selectedSlot = s;
			break
	#Then, if you didn't find an appropriate stack, find the first empty slot
	if selectedSlot == null:
		for s in slots:
			if s.heldItem == null:
				selectedSlot = s
				break				
	#if you still get no slot, return false
	if selectedSlot == null:
		return false
	#otherwise, add the item to the slot.
	selectedSlot.heldItem = item 
	selectedSlot.quantity += amount
	return true

	
func removeItem(item:invItem, amount:int):
	var selectedSlot:ItemSlot = null
	#Check if you have amount of an item
	for s in slots:
		var i = s.heldItem
		if i .itemID == item.itemID and s.quantity >= amount:
			selectedSlot = s;
			break
	if selectedSlot == null:
		return false		
	selectedSlot.quantity -=amount
	return true
	
func removeItemFromSlot(slot:ItemSlot, amount:int):
	if slot.quantity >= amount:
		slot.quantity -= amount
		return true
	return false 
	
func switchItems(slotA:int,slotB:int):
	var temp:invItem
	var tempAmount: int
	if	slotA < slots.size() and slotB < slots.size():
		temp = slots[slotA].heldItem
		tempAmount = slots[slotA].quantity
		slots[slotA].heldItem = slots[slotB].heldItem
		slots[slotA].quantity = slots[slotB].quantity
		slots[slotB].heldItem = temp
		
		
