function gu:generate
$data merge storage anysound:temp {name:"$(name)",author:"$(author)"}
data modify storage anysound:temp player.UUID set from entity @s UUID
data modify storage anysound:temp uuid set from storage gu:main out
data modify storage anysound:temp player.uuid set from storage anysound:temp uuid
execute if function anysound:sound_setting/main/no_record run data modify storage anysound:player data append from storage anysound:temp player
function anysound:sound_setting/main/main with storage anysound:temp
