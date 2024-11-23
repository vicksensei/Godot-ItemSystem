extends Control

@onready var nameLabel = $Panel/Name
@onready var priceLabel = $Panel/Price
@onready var descLabel = $Panel/DescPanel/Description

@onready var panel = $Panel
@onready var margin_container = $Panel/MarginContainer
@onready var desc_panel = $Panel/DescPanel

var item:invItem

func _ready():
	fixSize()
	pass

func setItem(newItem:invItem):
	item = newItem
	updateText()
	fixSize()

func updateText():
	nameLabel.text = item.itemName
	descLabel.text = item.desc
	priceLabel.text = item.normalSellPrice

func fixSize():
	desc_panel.size.y = descLabel.size.y + 10
	size.y = desc_panel.size.y + nameLabel.size.y +10
	pass
