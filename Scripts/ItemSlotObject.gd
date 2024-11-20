extends Object
class_name ItemSlot

var slotID:int
var quantity:int
var heldItemID:int

func create(id:int):
	slotID = id
	quantity = 0
	heldItemID = -1

func updateSlot():
	if quantity == 0:
		heldItemID = -1
	if heldItemID == -1:
		quantity == 0

		
func setItem(item:invItem, amount:int):
	heldItemID = item.itemID
	quantity = amount
