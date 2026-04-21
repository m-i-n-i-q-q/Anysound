advancement revoke @s only anysound:play
#execute if items entity @s weapon.mainhand goat_horn[custom_data~{"anysound:disc":{flag:{}}}] unless items entity @s weapon.offhand *[custom_data~{"anysound:disc":{flag:{}}}] 
execute if predicate anysound:playing_mainhand run return run function anysound:sound_playing/main with entity @s SelectedItem.components."minecraft:custom_data"."anysound:disc"
execute if predicate anysound:playing_offhand run return run function anysound:sound_playing/main with entity @s Inventory[{Slot:-106b}].components."minecraft:custom_data"."anysound:disc"