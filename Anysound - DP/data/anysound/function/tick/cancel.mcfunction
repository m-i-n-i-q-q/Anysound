scoreboard players set @s anysound.dialog 0
scoreboard players enable @s anysound.dialog
execute if entity @s[tag=!anysound.in_dialog] run return run tellraw @s {translate:"anysound.cancel.out_dialog",fallback:"Bro ,if you wanna open the sound setting dialog,you should trigger in value 1 or bigger number.",color:"yellow"}
tellraw @s {translate:"anysound.cancel",fallback:"The operation has been cancelled.",color:"red"}
tag @s remove anysound.in_dialog