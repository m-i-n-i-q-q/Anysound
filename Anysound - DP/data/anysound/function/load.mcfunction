gamerule max_command_forks 2147483647
gamerule max_command_sequence_length 2147483647
execute unless data storage anysound:player data run data modify storage anysound:player data set value []
scoreboard objectives add anysound.dialog trigger
scoreboard players add @a anysound.dialog 0
scoreboard players enable @a anysound.dialog
scoreboard objectives add anysound.playing.index dummy
scoreboard objectives add anysound.playing.loop dummy
scoreboard objectives add anysound.playing.delayflag dummy
scoreboard objectives add anysound.const dummy
scoreboard players set anysound.8 anysound.const 8
