scoreboard players operation @s anysound.playing.delayflag *= anysound.n1 anysound.const
execute store result entity @s data.anysound.index int 1 run scoreboard players add @s anysound.playing.index 1
execute if score @s anysound.playing.delayflag matches ..0 run function anysound:sound_playing/tick/main with entity @s data.anysound
