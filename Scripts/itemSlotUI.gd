extends Control
class_name ItemSlotUI
@export var bgColor: Color
@export var highlightColor: Color

@onready var item_image = $SlotBG/MarginContainer/ItemImage
@onready var label = $SlotBG/Label
@onready var margin_container = $SlotBG/MarginContainer
@onready var slot_bg = $SlotBG

var heldItem:invItem = null
var quantity:int = 0
var slotID: int = 0

func _ready():
	deHighlight() 
	item_image.material = item_image.material.duplicate()
	updateSlot()
	
	pass # Replace with function body.


func updateSlot():
	if heldItem == null:
		clearDisplay()
	if quantity == 0:
		heldItem = null
		clearDisplay()
	if quantity ==1:
		label.text = ""
	if quantity>1 and not heldItem == null:
		label.text = quantity

func setItem(item:invItem, amount:int):
	heldItem = item
	quantity = amount
	updateSlot()


func clearDisplay():
	label.text = ""
	item_image.texture = null
	
func highlight():
	slot_bg.self_modulate = highlightColor
	item_image.material.set_shader_parameter("isPlaying", true)

func deHighlight():
	slot_bg.self_modulate = bgColor
	item_image.material.set_shader_parameter("isPlaying", false)
	
func _on_mouse_entered():
	highlight()
	pass # Replace with function body.


func _on_mouse_exited():
	deHighlight()
	pass # Replace with function body.
