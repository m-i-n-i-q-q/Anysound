$data modify storage anysound_:analyzer slice.output.c set value 0b$(value)
execute store result score P0 io run data get storage anysound_:analyzer slice.output.c

#scoreboard players set P0 io 1199259045
function float:32/decompose/main
scoreboard players operation P0 io = R0 io
scoreboard players operation P1 io = R1 io
scoreboard players operation P2 io = R2 io
# convert to NBT storage. Return to {io.R0}
function float:32/convert/to_storage/main

data modify storage anysound_:analyzer slice.output.c set from storage hmmm:io R0