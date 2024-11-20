extends Object

var slots: Array[ItemSlot]
var IDB = preload("res://Custom Resources/allItems.tres")

func checkSpaceForItem(item:invItem):
	var max = item.maxStack
	var total_space = 0
	total_space = checkEmpySlots().size() * max
	for s in slots:
		if s.heldItemID == item.itemID:
			var remaining = max - s.quantity
			total_space += remaining

func checkEmpySlots():
	var availableSlots = []
	for s in slots:
		if s.heldItemID == 0:
			availableSlots.append(0)
	return availableSlots

func countItem(item:invItem):
	var amount = 0
	for s in slots:
		if s.heldItemID == item.itemID:
			amount += s.quantity
	return amount
	
func addItem(item:invItem, amount:int):
	#Check if you have room for the item at all
	var space = checkSpaceForItem(item)
	if( space < amount):
		return false
	var amountRemaining = amount
	#Check if you have any incomplete stacks of the item
	for s in slots:
		if s.heldItemID == -1: #if an empty slot
			continue		   #skip it for now
		var i:invItem = getItem( s.heldItemID)
		if i.itemID == item.itemID: #if it is a stack of the item
			if amountRemaining +s.quantity <= i.maxStack: 
				#if you have more space than you need 
				# or just the right amount, we're done.
				s.quantity += amountRemaining
				return true
			else: 
				#otherwise, add as much as you can
				#and keep going with the amount you have left
				var slotSpace = i.maxStack - s.quantity
				s.quantity += slotSpace
				amountRemaining -= slotSpace
	#once you're done with the partial slots and still have some left over
	#check the empty slots
	var emptySlots:Array[ItemSlot] = checkEmpySlots()
	for e in emptySlots:
		#if you still have amount remaining enough to fill a slot, 
		if amountRemaining > 0:
			#if you have more than the slot can hold (or the exact amount)
			if amountRemaining >= item.maxStack:
				#create a full stack
				e.setItem(item, item.maxStack)
				amount-= item.maxStack
			else: #you have less than a full stack
				#create a partial stack
				e.setItem(item, amountRemaining)
				return true;
		else: #amount should be zero
			return true

func removeItem(item:invItem, amount:int) -> bool:
	#check if you have enough of the item
	if amount > countItem(item):
		return false; #don't bother to keep going
	#since we do have enough, remove the as much of the item from every slot
	var amountRemaining = amount
	for s in slots:
		var i = getItem(s.heldItemID)
		if amountRemaining > 0:
			if i.itemID == item.itemID:
				#when you find a stack of the item in a slot
				if amountRemaining >= s.quantity: #if you need more than you have
					amountRemaining -= s.quantity#empty the stack
					s.quantity = 0
					s.updateSlot();
				else: #you have more than you need
					s.quantity -= amountRemaining
					return true
		else:
			return true
	#
	print("Something went wrong")
	return false	
func removeItemFromSlot(slot:ItemSlot, amount:int) ->bool:
	if slot.quantity >= amount:
		slot.quantity -= amount
		slot.updateSlot()
		return true
	return false 
	
func switchItems(slotA:int,slotB:int):
	var tempAmount: int
	var tempID: int
	if	slotA < slots.size() and slotB < slots.size():
		
		tempID = slots[slotA].heldItemID
		tempAmount = slots[slotA].quantity
		
		slots[slotA].heldItemID = slots[slotB].heldItemID
		slots[slotA].quantity = slots[slotB].quantity
		
		slots[slotB].heldItemID = tempID
		slots[slotB].quantity = tempAmount
		
func getItem(itemID) -> invItem:
	if itemID < IDB.ItemDB.size():
		return IDB.ItemDB[itemID]
	return null
	
