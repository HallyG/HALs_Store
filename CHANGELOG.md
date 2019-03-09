# Changelog

## Version 1.3
### Additions
* ADDED: (Function) `HALs_store_fnc_addMoneyOnOpen`
* ADDED: (Option) Setting to change currency symbol

* CHANGED: (Config) Everything is initialised automatically through `HALs/Addons/main`
___
## Version 1.2
### Fixes
* FIXED: The mass of items of containers within containers were not calculated.
* FIXED: Edit box maximum characters set to 6 (credits to: R3vo).
* FIXED: Players couldn't buy items in multiplayer (credits to: Antoine)
* OPTIMIZED: Removed the creation of unneccesary private variables.
* OPTIMIZED: `HALs_store_fnc_main`, `HALs_store_fnc_initModule`, `HALs_store_fnc_blur`, `HALs_fnc_getModuleRoot`

### Additions
* ADDED: (Function) HALs_store_fnc_getItemType
* ADDED: (Function) HALs_fnc_getModuleSettings
* ADDED: Spanish Translation thanks to Kain181.
* ADDED: French Translation thanks to vbr74.

* CHANGED: (Dialog) Visual changes. Text should be easier to read and dialog should scale better with different resolutions
* CHANGED: (Config) The configuration files for HALs_Money and HALs_Store have been moved from the `description.ext` to `config.hpp` in their respective folders.
  * HALs_Money: `HALs\Addons\Money\config.hpp`
  * HALs_Store: `HALs\Addons\Store\config.hpp`
___
## Version 1.1
### Fixes
* FIXED: Could not equip a sniper/shotgun if the equip checkbox was checked.
* FIXED: Mass of glasses were considered 0.
* FIXED: Could buy items to the inventories of other traders.
* FIXED: Could trade with dead traders.
* FIXED: Could trade with traders while in a vehicle.
* FIXED: Could not equip item if container was completely full/no container existed (Now, the equip checkbox must be checked).
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
* TBF
