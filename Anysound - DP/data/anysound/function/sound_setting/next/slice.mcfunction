execute if data storage anysound_:analyzer {part:"="} run return run function anysound:sound_setting/next/output/main with entity @s
data modify storage anysound_:analyzer slice.input set string storage anysound_:analyzer part 0 20
data modify storage anysound_:analyzer part set string storage anysound_:analyzer part 20
data modify storage anysound_:analyzer slice.output.raw.q set string storage anysound_:analyzer slice.input 0 1
data modify storage anysound_:analyzer slice.output.raw.g set string storage anysound_:analyzer slice.input 1 2
data modify storage anysound_:analyzer slice.output.raw.m set string storage anysound_:analyzer slice.input 2 8
data modify storage anysound_:analyzer slice.output.raw.s set string storage anysound_:analyzer slice.input 8 14
data modify storage anysound_:analyzer slice.output.raw.c set string storage anysound_:analyzer slice.input 14
function anysound:sound_setting/next/slice/convert with storage anysound_:analyzer slice.output.raw