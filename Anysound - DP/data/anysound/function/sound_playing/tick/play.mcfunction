#$execute if data entity @s data.anysound{loop:0} 
$execute unless data storage $(storage) data[{name:"$(name)"}].data[$(index)][$(loop)] run return run function anysound:sound_playing/tick/move
$function anysound:sound_playing/tick/play/main with storage $(storage) data[{name:"$(name)"}].data[$(index)][$(loop)]

function anysound:sound_playing/tick/play/loop with entity @s data.anysound

function anysound:sound_playing/tick/play with entity @s data.anysound
