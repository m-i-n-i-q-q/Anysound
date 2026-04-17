advancement revoke @s only anysound:play
#execute if items entity @s weapon.mainhand goat_horn[custom_data~{"anysound:disc":{flag:{}}}] unless items entity @s weapon.offhand *[custom_data~{"anysound:disc":{flag:{}}}] 
execute if predicate anysound:playing run function anysound:sound_playing/main with entity @s SelectedItem.components."minecraft:custom_data"."anysound:disc"