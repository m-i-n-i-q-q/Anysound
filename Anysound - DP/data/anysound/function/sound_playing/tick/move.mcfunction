
$item modify entity @s container.0 {function:"minecraft:set_custom_model_data",floats:{mode:"append",values:[{type:"minecraft:sum",summands:[$(index),1]}]}}
data modify entity @s data.anysound.index set from entity @s item.components."minecraft:custom_model_data".floats[-1]
#kill @s