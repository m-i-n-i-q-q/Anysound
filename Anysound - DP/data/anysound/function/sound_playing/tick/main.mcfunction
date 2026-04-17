#execute if data entity @s data.anysound{index:0}
$execute unless data storage $(storage) data[{name:"$(name)"}].data[$(index)] run return run function anysound:sound_playing/tick/play/end
#$execute store result entity @s data.anysound.loop float -1 run data get storage $(storage) data[{name:"$(name)"}].data[$(index)]
execute store result entity @s data.anysound.loop int 1 run scoreboard players set @s anysound.playing.loop 0
#data modify entity @s data.anysound.loop set value 0
#$execute if data entity @s data.anysound{loop:0} 
$execute unless data storage $(storage) data[{name:"$(name)"}].data[$(index)][0] run return run function anysound:sound_playing/tick/move

function anysound:sound_playing/tick/play with entity @s data.anysound
