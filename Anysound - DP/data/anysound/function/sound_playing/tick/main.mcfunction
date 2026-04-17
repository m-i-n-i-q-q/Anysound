$execute unless data storage $(storage) data[{name:"$(name)",author:"$(author)"}].data[$(index)] run return run function anysound:sound_playing/tick/play/end
$execute unless data storage $(storage) data[{name:"$(name)",author:"$(author)"}].data[$(index)][0] run return run function anysound:sound_playing/tick/move
execute store result entity @s data.anysound.loop int 0 run scoreboard players set @s anysound.playing.loop 0
function anysound:sound_playing/tick/play with entity @s data.anysound
