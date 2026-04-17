$execute unless data storage $(storage) data[{name:"$(name)"}].data[$(index)][$(loop)] run return run function anysound:sound_playing/tick/move
$function anysound:sound_playing/tick/play/main with storage $(storage) data[{name:"$(name)"}].data[$(index)][$(loop)]

execute store result entity @s data.anysound.loop int 1 run scoreboard players add @s anysound.playing.loop 1

function anysound:sound_playing/tick/play with entity @s data.anysound
