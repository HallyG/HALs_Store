# Changelog

## Version 1.1
### Fixes
* FIXED: Could n0t equip a sniper/shotgun if the equip checkbox was checked.
* FIXED: Mass of glasses were considered 0.
* FIXED: Could buy items to the inventories of other traders.
* FIXED: Could trade with dead traders.
* FIXED: Could not equip item if container was completely full/no container existed.
* FIXED: Backpack pictures were not showing.
* FIXED: Backpack stats were not working.

### Additions
* ADDED: German Translation thanks to 7erra.
* ADDED: Items can now have custom structured text descriptions. 
* ADDED: fn_purchase added message if player couldnt equip item.
  * Uses new stringtable entry ("STR_HALS_STORE_ITEM_NOEQUIP").
  
* ADDED: traders can be any type now ("CAManBase", "ReammoBox_F" or "Car_F").
  * NB automatically clears a traders inventory on init if they are not type "CAManBase"
  * If trader is type "CAManBase", can only purchase to player's uniform/vest/backpack.
  
* ADDED: Stats for weapons, uniform, vests, backpacks and optics.
![](http://i.imgur.com/piowiF0.jpg) ![](http://i.imgur.com/cXhrtyh.jpg) ![](http://i.imgur.com/LyaFDse.jpg)

### Bugs
* Can't purchase item if container is full (fix is wip).
