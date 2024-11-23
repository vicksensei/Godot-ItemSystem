extends Resource
class_name ItemData

@export var ItemDB: Array[invItem]


func getItem(itemID) -> invItem:
	
	if itemID < ItemDB.size():
		var item = ItemDB[itemID]
		return item
	return null
