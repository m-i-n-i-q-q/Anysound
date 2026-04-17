$data modify entity @s data.anysound merge value {storage:"anysound_$(uuid):sound",name:"$(name)",author:"$(author)"}

#$data modify entity @s data.anysound.storage set value "anysound_$(uuid):sound"
#$data modify entity @s data.anysound.name set value "$(name)"
#function gu:generate
#data modify entity @s data.anysound.uuid set from storage gu:main out

##😒
#scoreboard players set @s anysound.playing.delayflag 1
#scoreboard players set @s anysound.playing.index 0
#data modify entity @s data.anysound.index set value 0
##😏
execute store success score @s anysound.playing.delayflag run scoreboard players set @s anysound.playing.index 0


#start
tag @s add anysound.playing