#item replace entity @s container.0 with egg[item_model="minecraft:air"]
$item modify entity @s container.0 {function:"minecraft:set_custom_model_data",floats:{mode:"append",values:[{type:"minecraft:sum",summands:[$(loop),1]}]}}
data modify entity @s data.anysound.loop set from entity @s item.components."minecraft:custom_model_data".floats[-1]
#kill @s