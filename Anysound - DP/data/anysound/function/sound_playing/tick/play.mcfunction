$execute if data entity @s data.anysound{loop:0} run return run function anysound:sound_playing/tick/move {index:$(index)}
$function anysound:sound_playing/tick/play/main with storage $(storage) data[{name:"$(name)"}].data[$(index)][$(loop)]

$execute summon item_display run function anysound:sound_playing/tick/play/loop {loop:$(loop)}

function anysound:sound_playing/tick/play with entity @s data.anysound
