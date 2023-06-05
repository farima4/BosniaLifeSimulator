extends Node

# Weapons
# 0 - mele
# 1 - normal
var weapons = {
	"empty" : [preload("res://Weapons/empty/weapon.tscn").instantiate(), 1],
	"knife" : [preload("res://Weapons/knife/weapon.tscn").instantiate(), 0],
	"glock" : [preload("res://Weapons/glock/weapon.tscn").instantiate(), 1]
}
