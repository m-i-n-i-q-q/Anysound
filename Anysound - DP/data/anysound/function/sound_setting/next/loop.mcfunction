#execute if data storage anysound_:analyzer {index:0} run return run function anysound:sound_setting/next/output/done
execute unless data storage anysound_:analyzer raw[0] run return run function anysound:sound_setting/next/output/done with entity @s
#data modify storage anysound_:analyzer loop[0] set from storage anysound_:analyzer index
#execute at @s summon item_display run function anysound:sound_setting/next/move with storage anysound_:analyzer
data modify storage anysound_:analyzer part set from storage anysound_:analyzer raw[0]
data remove storage anysound_:analyzer raw[0]
execute if data storage anysound_:analyzer {part:"empty"} run return run function anysound:sound_setting/next/output/empty with entity @s
function anysound:sound_setting/next/padding with storage anysound_:analyzer
function anysound:sound_setting/next/slice