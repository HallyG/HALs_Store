# Changelog

## Version 1.1
* FIXED: Couldn't equip a sniper/shotgun if the equip checkbox was checked.
* FIXED: Mass of glasses was considered 0.
* FIXED: Could buy items to the inventories of other traders.
* FIXED: Could trade with dead traders.
* FIXED: Couldn't equip item if container was completely full/no container existed.

* ADDED: Stats for weapons, uniform, vests, backpacks and optics.
* ADDED: German Translation thanks to 7erra.
* ADDED: fn_purchase added message if player couldnt equip item.
  * Uses new stringtable entry ("STR_HALS_STORE_ITEM_NOEQUIP")

* ADDED: traders can be any type now ("CAManBase", "ReammoBox_F" or "Car_F")
  * NB automatically clears a traders inventory on init if they are not type "CAManBase"
  * If trader is type "CAManBase", can only purchase to player's uniform/vest/backpack.
