item replace entity @s container.0 with egg
$item modify entity @s container.0 {function:"minecraft:set_custom_model_data",floats:{mode:"append",values:[{type:"minecraft:sum",summands:$(loop)}]}}
execute store result storage anysound_:analyzer index int 1 run data get entity @s item.components."minecraft:custom_model_data".floats[0]
kill @s