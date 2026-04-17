<<<<<<< HEAD
execute as @e[tag=anysound.playing,type=item_display] at @s run function anysound:sound_playing/tick/main with entity @s data.anysound
=======
execute as @e[type=marker,tag=anysound.playing] at @s run function anysound:sound_playing/tick/main with entity @s data.anysound
>>>>>>> c63650ebff383bc92a72c7ac7125249e832d6190
